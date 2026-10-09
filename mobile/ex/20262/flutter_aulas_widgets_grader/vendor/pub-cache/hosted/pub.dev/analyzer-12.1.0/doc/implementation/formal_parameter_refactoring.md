# FormalParameter Refactoring

This document outlines the refactoring of the `FormalParameter` AST hierarchy in the Dart analyzer. The goal is to flatten the hierarchy, remove the `DefaultFormalParameter` wrapper node, and eliminate the separate `FunctionTypedFormalParameter` node in favor of a compositional approach.

## 1. Current State (Legacy Design)

The current hierarchy is deep and utilizes a "wrapper" pattern for default values, which complicates AST traversal (necessitating `.unwrapped` checks) and separates parameter flags from their declarations.

### Hierarchy

*   `FormalParameter` (Abstract)
    *   **`DefaultFormalParameter`** (Wrapper)
        *   Contains `NormalFormalParameter parameter` (the wrapped node)
        *   Contains `Expression? defaultValue`
        *   Contains `Token? separator`
    *   **`NormalFormalParameter`** (Abstract)
        *   **`SimpleFormalParameter`** (`int x`)
        *   **`FunctionTypedFormalParameter`** (`void callback()`)
        *   **`FieldFormalParameter`** (`this.x`, optionally function-typed)
        *   **`SuperFormalParameter`** (`super.x`, optionally function-typed)

### Pain Points

1.  **Wrapper Complexity (Default Values):** The `DefaultFormalParameter` node acts as a wrapper around the actual parameter definition (`NormalFormalParameter`). This forces visitors to constantly "unwrap" nodes or check `parent` pointers to access basic information like the parameter's name or metadata, creating a disconnect between the parameter's identity and its default value.
2.  **Duplicated Function-Typing State:** The concept of a "function-typed" parameter (e.g., `void f(int i)`) is implemented by duplicating the same fields (`parameters`, `typeParameters`, `question`) across three distinct AST classes: `FunctionTypedFormalParameter`, `FieldFormalParameter`, and `SuperFormalParameter`. This forces consumers to check multiple types to handle function-typed parameters generically.
3.  **Inconsistent Hierarchy:** `SimpleFormalParameter` represents a non-function-typed parameter, yet its siblings (`Field` and `Super`) can be *either* simple *or* function-typed. This asymmetry makes the hierarchy harder to reason about and contributes to the scattered access patterns mentioned above.

---

## 2. New Design (Target State)

The new design flattens the hierarchy, removing `DefaultFormalParameter` and `NormalFormalParameter`. Features like "default values" and "function typing" become **compositional capabilities** of the base `FormalParameter` class.

### Hierarchy

*   `FormalParameter` (Abstract)
    *   **`RegularFormalParameter`** (Replaces `Simple` & `FunctionTyped`)
    *   **`FieldFormalParameter`** (`this.x`)
    *   **`SuperFormalParameter`** (`super.x`)
    *   *Shared Compositional State:*
        *   `FormalParameterDefaultClause? defaultClause` (encapsulates `= value`)
        *   `FunctionTypedFormalParameterSuffix? functionTypedSyntax` (encapsulates `(...)`)

### Detailed Structure

*   **`FormalParameter`** (Abstract)
    *   **Shared State (Fields):**
        *   `Token name`
        *   `TypeAnnotation? type` (Acts as variable type *or* return type)
        *   `Token? keyword` (`final`, `const`, `var`)
        *   `Token? covariantKeyword`
        *   `Token? requiredKeyword` (for named parameters)
    *   **Shared Compositional Children:**
        *   **`FormalParameterDefaultClause? defaultClause`** (Holds separator + value)
        *   **`FunctionTypedFormalParameterSuffix? functionTypedSyntax`** (Holds `(params)`, `<T>`, `?`)
    *   **Convenience Getters:**
        *   `bool isConst`, `bool isFinal`

*   **`RegularFormalParameter`** (Concrete)
    *   *Replaces `SimpleFormalParameter` and `FunctionTypedFormalParameter`.*
    *   Used for standard parameters (`int x`, `void f()`).

*   **`FieldFormalParameter`** (Concrete)
    *   *Inherits all base capabilities (so defaults/function-typing work implicitly).*
    *   Adds: `Token thisKeyword`, `Token period`.

*   **`SuperFormalParameter`** (Concrete)
    *   *Inherits all base capabilities.*
    *   Adds: `Token superKeyword`, `Token period`.

### Helper Nodes

*   **`FormalParameterDefaultClause`**
    *   `Token separator` (`=` or `:`)
    *   `Expression value`
    *   *Benefit:* Enforces that separator and value strictly appear together.

*   **`FunctionTypedFormalParameterSuffix`**
    *   `TypeParameterList? typeParameters`
    *   `FormalParameterList formalParameters`
    *   `Token? question`
    *   *Benefit:* Deduplicates complex function-typing logic from `Field`/`Super` parameters.

---

## 3. Advantages

1.  **Traversal Simplicity:** No more unwrapping `DefaultFormalParameter` or checking if `parent is DefaultFormalParameter`. The `name` and `metadata` are always on the node you have.
2.  **Unified Function Typing:** "Regular" parameters (`void f()`) and member parameters (`void this.f()`) use the same `functionTypedSyntax` suffix structure.
3.  **Defining Errors Out of Existence:** By encapsulating the separator and value within a single nullable `FormalParameterDefaultClause`, we make it structurally impossible to represent the invalid state of "having a separator but no value" (or vice-versa) at the `FormalParameter` level. This adheres to the principle of "Defining Errors Out of Existence" (as described in *A Philosophy of Software Design*), reducing exception handling complexity for consumers.
4.  **Semantic Clarity:** `RegularFormalParameter` explicitly denotes a standard local variable binding, distinct from member initialization (`this.`) or super forwarding (`super.`).

---

## 4. API Migration Plan

We can split the migration into two distinct phases to minimize client breakage. While the structural change (removing `DefaultFormalParameter`) is inevitably breaking, we can allow clients to migrate their **data access patterns** in a minor version before the types disappear.

### Phase 1: Preparation (Non-Breaking / Minor Version)

**Goal:** enabling clients to write code against the *future* AST structure (`RegularFormalParameter`, `defaultClause`) while running on the *current* AST implementation. This allows for a seamless transition where clients can update their visitors one by one.

1.  **Introduce `RegularFormalParameter` Interface:**
    *   Define `RegularFormalParameter` as an abstract interface implementing `FormalParameter`.
    *   Update `SimpleFormalParameter` and `FunctionTypedFormalParameter` to implement `RegularFormalParameter`.
    *   **Bridge Properties:** Implement `defaultClause` on `Simple`/`FunctionTyped` by checking `parent is DefaultFormalParameter`.
        *   *Result:* Clients handling a `RegularFormalParameter` can access `node.defaultClause` seamlessly, unaware that it's physically coming from a parent wrapper node.

2.  **Visitor Bridging (The Trick):**
    *   Add `visitRegularFormalParameter` to `AstVisitor` (defaulting to `visitFormalParameter`).
    *   Update standard base visitors (`GeneralizingAstVisitor`, `RecursiveAstVisitor`, etc.) to forward calls:
        *   `visitSimpleFormalParameter` -> calls `visitRegularFormalParameter`.
        *   `visitFunctionTypedFormalParameter` -> calls `visitRegularFormalParameter`.
    *   *Result:*
        *   Legacy clients overriding `visitSimple...` continue to work (base implementation calls them).
        *   Migrated clients overriding `visitRegularFormalParameter` get called automatically for both node types.
        *   Hybrid clients overriding both handle their own dispatch (usually via `super`).

3.  **Introduce Helper Nodes:**
    *   Define `FormalParameterDefaultClause` and `FunctionTypedFormalParameterSuffix`.
    *   Expose synthetic views:
        *   `FormalParameter.defaultClause`: Returns a wrapper around `separator/defaultValue` (either from self or parent `DefaultFormalParameter`).
        *   `FormalParameter.functionTypedSyntax`: Returns a wrapper around `parameters`, `typeParameters`, etc.

**Client Impact (Minor Version):**
*   **Opt-in Migration:** Clients can start implementing `visitRegularFormalParameter` and using `node.defaultClause`. Their code will work immediately and *continue* to work after the major version upgrade.
*   **Zero Breakage:** Existing visitors (`visitSimple...`) behave exactly as before.

### Phase 2: Execution (Breaking / Major Version)

**Goal:** Flip the switch. Change the parser/builder to produce the new AST structure, remove the `DefaultFormalParameter` wrapper, and replace `Simple`/`FunctionTyped` with `Regular`.

1.  **AST Transformation:**
    *   Stop producing `DefaultFormalParameter` and `FunctionTypedFormalParameter`.
    *   Start producing `RegularFormalParameter`.
    *   Helper nodes (`defaultClause`, `functionTypedSyntax`) become real children, not synthetic views.

2.  **Visitor Changes:**
    *   **Breaking:** `visitDefaultFormalParameter` will no longer be called (node never exists).
    *   **Breaking:** `visitSimpleFormalParameter` and `visitFunctionTypedFormalParameter` will no longer be called.
    *   **New:** `visitRegularFormalParameter` is effectively the new "catch-all".

**Client Impact (Major Version):**
*   **Work:** Clients MUST update their visitors.
    *   Logic inside `visitDefaultFormalParameter` (handling defaults) must move to `visitFormalParameter` (or specific leaf visitors) and check `node.defaultClause`.
    *   Logic inside `visitSimple` and `visitFunctionTyped` must be merged into `visitRegularFormalParameter`.

### Work Estimates & Versioning

*   **Total Versions:** 2 (1 Minor + 1 Major).
*   **Analyzer Work:**
    *   *Minor:* ~2-3 days (Defining interfaces, wiring up bridging getters, adding deprecations).
    *   *Major:* ~1 week (Parser/Builder rewrite, updating all internal analyzer phases/resolvers to usage the new structure).
*   **Client Work:**
    *   *Minor:* Optional. Large clients (Google internal) can start migrating property accesses.
    *   *Major:* Significant. Every visitor handling parameters needs a rewrite. Structure changes are hard to automate completely, but `sed` scripts can help rename visitor methods.

### Can we visit `FormalParameterDefaultClause` in the Minor Version?
**Yes, with care.** We can introduce `FormalParameterDefaultClause` and `FunctionTypedFormalParameterSuffix` as real AST nodes (albeit synthetically created on demand or lazily).

*   **Implementation:** `FormalParameter.defaultClause` returns a synthetic instance of `FormalParameterDefaultClause` that wraps the underlying `separator` and `defaultValue`.
*   **Visitation:** We update `FormalParameter.visitChildren` to call `defaultClause?.accept(visitor)`.
*   **Client Responsibility:** Clients must choose:
    *   **Old Way:** Implement `visitDefaultFormalParameter` and inspect `node.defaultValue`.
    *   **New Way:** Implement `visitFormalParameterDefaultClause`.
    *   *Constraint & Solution:* To prevent double-visiting `defaultValue` (once as a direct child, once via `defaultClause`), we will update `RecursiveAstVisitor` (and similar base classes).
        *   **Current:** `visitDefaultFormalParameter` visits `parameter` then `defaultValue`.
        *   **Updated:** `visitDefaultFormalParameter` will visit `parameter` then `defaultClause`.
        *   **Effect:** This ensures `defaultValue` is visited exactly once (as a child of `defaultClause`). Clients extending `RecursiveAstVisitor` get this fix automatically. Clients implementing `AstVisitor` directly or overriding `visitDefaultFormalParameter` without calling super must presumably update their traversal logic manually.

