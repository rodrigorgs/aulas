# Formal Parameters: Declarations vs Types

This document outlines the design Philosophy and architectural tension surrounding the representation of formal parameters inside the analyzer’s element model, specifically regarding call-site resolution (`correspondingFormalParameter`).

## 1. The Background Friction

Historically, resolving a named or positional argument to its formal parameter has provided a fully-fledged `FormalParameterElement`. While elegant on the surface, this triggers a structural tension for generic methods and instantiated invocations.

At a generic call site (e.g., `foo<int>()` where `foo({T bar})` was declared), the resolver maps arguments to a formal formal parameter list reflecting generic bounds.

### 1.1 Substituted Elements are Sound
For generic invocations, the resolver utilizes **`SubstitutedFormalParameterElementImpl`** (allocated from the instantiated signature). 

This layout is **structurally solid** and honors the interface nicely:
*   It carries the substituted type context accurately for that call site.
*   It correctly overrides `.baseElement` back to the raw descriptive declaration node anchor.

### 1.2 The Issue: Non-Element Synthetic Clones
The breakage occurs with purely synthetic formal parameter cloning, typically created via **`.copyWith()`** used heavily in Type Algebra (such as GLB/LUB computation for `FunctionType` layouts) or simulated resolvers.

Because pure synthetic creators used to return `this` for `.baseElement` (acting as their own canonical definition), they would drop the link back to the root descriptive declaration layout structure. This can trick consumer tools (like Refactorings, Hover popups, and Indexers) into consuming cloned state without anchor traces, breaking jump-to-definition triggers.

---

## 2. The Core Architectural Tension

The analyzer operates under a core philosophical split:
*   **Elements:** Represent a declarative unit anchored in source fragments.
*   **Types:** Represent semantic, instantiated, contextual bindings.

### 2.1 FunctionTypes Exist in Memory "Nowhere"
Unlike a `MethodElement` or `ClassElement`, a **`FunctionType`** does not exist at a static source declaration anchor on disk. It is a structural type synthesized dynamically by the type system (e.g., during type substitution, least-upper-bound calculations, or variable layout analysis). It has no file location or code snippet implicitly bound to it.

### 2.2 The Re-use Dilemma
Because a `FunctionType` is purely structural, it doesn't have authored declarative formal parameters to load. 

However, to maintain **API Uniformity**—ensuring IDE hovers, autocomplete engines, and diagnostics can walk invocations without duplicating logic—the analyzer forces `FunctionType` formal parameters to re-use canonical **`FormalParameterElementImpl`** layouts. 

*   **The Benefit:** Clients get standard access to `.name`, `.type`, and covariance states.
*   **The Strain:** It mixes declarative models with instantiated data structs. To bridge this, the type system allocates "off-tree" synthetic Elements. These synthetic elements must maintain explicit back-links (like `.baseElement`) back to declaration layouts to ensure refactorings do not land in dead ends.

---

## 3. Application of "A Philosophy of Software Design"

Applying principles from John Ousterhout’s Software Design framework highlights clear repair paths:

### A. Different Things Should Be Separate
Evaluating an argument's declaration (Navigation, Documentation, Rename) and its call-site safety (Type Inference) are two distinct needs. Standard `SubstitutedFormalParameterElementImpl` satisfies both cleanly by maintaining a `.baseElement` back-link. Obscurity only enters when developers walk into purely synthetic temporary allocations that drop this back-reference.

### B. Define Errors Out of Existence
If `.correspondingFormalParameter` is designed to **guarantee** that it returns canonical declaration Elements strictly, the edge-cases where refactoring tools inspect synthetic clones become structurally impossible. 

---

## 4. Targeted Value-Object Design

Rather than forcing clients to query instantiated signature lists manually, a clean separation would involve a **formal parameter View Object** from the AST anchor:

```dart
// ignore_for_file: undefined_class
abstract class ArgumentFormalParameter {
  /// The original declaration from authored code (if any).
  /// Used by: Navigation, Refactoring, Docs.
  FormalParameterElement? get declaration;

  /// The fully substituted type at this generic call site.
  /// Used by: Inference, completions, inlay hints.
  DartType get type;

  ParameterKind get kind;
  String? get name; // Nullable for anonymous positional FunctionType parameters.
}
```

By providing a specialized struct view of argument binding that explicitly isolates declaration bindings from type instantiated bindings, we eliminate the smell of synthesis leaks while fully supporting clients that require both data views.

---

## 5. Future Direction: Decoupling `FunctionType` formal parameters

While Value-Object views solve address call-site friction on AST nodes, they leave `FunctionType` itself relying on allocates synthetic `FormalParameterElement` items for purely structural layouts. 

A further step toward **Model Purity** could involve formalizing a pure-type struct for dynamically synthesized signatures:

```dart
// ignore_for_file: undefined_class
abstract class FunctionTypeFormalParameter {
  /// Structural attributes not anchored to any file snippet.
  String? get name;
  DartType get type;
  ParameterKind get kind;
  
  bool get isCovariant;
}
```

### Options:
*   **The Win:** Pure algebra operations (GLB, LUB, instantations) will no longer need to manage simulated offsets, fake fragments, or `.baseElement` back-link repairs inside memory calculations.
*   **The Cost:** downstream clients (completion suggestion passes, doc hovers, diagnostic assertions) would lose the single-interface uniform loop (walking `Iterable<FormalParameterElement>`), imposing an explicitly branched traversal pattern across declaration tables and in-memory type operations.

Codifying specialized structs inside argument bindings acts as a pragmatic middle ground before committing to a total migration of call-site layouts.

---

## 6. Future Direction: Modernizing `ParameterKind` (`FormalParameterKind`)

While outside the primary scope of argument-node resolving logic, the **`ParameterKind`** model contains architectural debt that could further improve layout safety if modernized.

### 6.1 The Emulated Enum relic
Currently, `ParameterKind` is fully modeled as a `class` that utilizes `static const` instances and an `ordinal` property. This creates two design frictions:
1.  **State Replication:** It defines 8 separate boolean fields for a basic 4-state model machine (Positional/Named $\times$ Required/Optional).
2.  **Breaks Exhaustiveness:** Callers cannot walk it safely in a `switch` statement or pattern match with Dart 3.0 compiler validation, because the compiler fails to guarantee item coverage without a `default:` fallback.

### 6.2 Proposing `FormalParameterKind`
Refactoring this into an **Enhanced Enum** solves ambiguity and restores safety triggers:

```dart
enum FormalParameterKind {
  requiredPositional(isNamed: false, isRequired: true),
  optionalPositional(isNamed: false, isRequired: false),
  requiredNamed(isNamed: true, isRequired: true),
  optionalNamed(isNamed: true, isRequired: false);

  final bool isNamed;
  final bool isRequired;

  const FormalParameterKind({required this.isNamed, required this.isRequired});

  bool get isPositional => !isNamed;
  bool get isOptional => !isRequired;
  
  bool get isRequiredPositional => isPositional && isRequired;
}
```

This layout strictly enforces orthogonality axes, simplifies implementation maintenance, and guarantees full compile-time exhaustiveness safety for downstream clients.

