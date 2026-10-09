# Modeling Formal Parameter Fragment Chains for Augmentations

This document outlines the structural modifications to the Dart analyzer's element model to support heterogeneous fragment chains for formal parameters. In the context of the augmentations language feature, a parameter's chain may contain a mix of Field Formal and Regular parameters (or Super Formal and Regular parameters).

## 1. Current State

Currently, the element model assumes that a parameter's fragment chain is homogeneous. That is, if a parameter is introduced as a `FieldFormalParameterFragment` (e.g. `this.x`), all subsequent augmenting declarations for that parameter are assumed to also be `FieldFormalParameterFragment`s.

This is enforced via strict type casts in the implementation:

```
// pkg/analyzer/lib/src/dart/element/element.dart

class FieldFormalParameterFragmentImpl extends FormalParameterFragmentImpl
    with _FieldFormalParameterFragmentImplMixin
    implements FieldFormalParameterFragment {
  
  @override
  FieldFormalParameterFragmentImpl? get nextFragment =>
      super.nextFragment as FieldFormalParameterFragmentImpl?; // <-- Hard cast
}
```

The matching public interfaces also declare specific return types:

```
// pkg/analyzer/lib/dart/element/element.dart

abstract class FieldFormalParameterElement implements FormalParameterElement {
  @override
  FieldFormalParameterFragment get firstFragment;

  @override
  List<FieldFormalParameterFragment> get fragments;
}
```

### The Problem

According to the augmentations specification (see [feature-specification.md](https://github.com/dart-lang/language/blob/main/working/augmentations/feature-specification.md)), when augmenting a constructor, at most **one** declaration can use initializing formals or super parameters. All other declarations for that same parameter in the chain **must** use regular parameters.

A valid chain can therefore be `Field -> Regular -> Regular` (or `Regular -> Field -> Regular`, etc).

For example, starting with a field formal parameter:

```
class C {
  int x;
  C(this.x); // FieldFormalParameterFragment
}

augment class C {
  augment C(int x); // FormalParameterFragment (Regular)
}
```

Or starting with a regular parameter:

```
class C {
  int x;
  C(int x); // FormalParameterFragment (Regular)
}

augment class C {
  augment C(this.x); // FieldFormalParameterFragment
}
```

The current homogeneity assumption causes two main issues:
1.  **Type Cast Failures**: Traversing the chain (e.g. in `detachElementsFromNodes`) results in a runtime crash (`type 'FormalParameterFragmentImpl' is not a subtype of type 'FieldFormalParameterFragmentImpl?' in type cast`).
2.  **Element-Level Bias**: The element instance is created based solely on the *first* fragment's kind, without inspecting the full chain to determine the correct logical subtype.

---

## 2. New Design (Target State)

The new design removes the homogeneity assumption and allows the fragment chain to be **heterogeneous**, while processing the entire chain before deciding the unified Element subclass.

### Detailed Structure

The public interfaces are relaxed to return the general `FormalParameterFragment` where appropriate.

*   **`FieldFormalParameterElement` (Public API Changes):**
    ```
    abstract class FieldFormalParameterElement implements FormalParameterElement {
      @override
      FormalParameterFragment get firstFragment; // Changed from FieldFormalParameterFragment

      @override
      List<FormalParameterFragment> get fragments; // Changed from List<FieldFormalParameterFragment>
    }
    ```

*   **`FieldFormalParameterFragment` (Public API Changes):**
    ```
    abstract class FieldFormalParameterFragment implements FormalParameterFragment {
      @override
      FormalParameterFragment? get nextFragment; // Changed from FieldFormalParameterFragment?

      @override
      FormalParameterFragment? get previousFragment; // Changed from FieldFormalParameterFragment?

      @override
      FormalParameterElement get element; // Relaxed from FieldFormalParameterElement
    }
    ```

*Identical changes apply to `SuperFormalParameterElement` and `SuperFormalParameterFragment`.*

---

## 3. Advantages

1.  **Specification Compliance**: Correctly models the "at most one" rule for initializing formals and super parameters in the augmentations feature.
2.  **Client Stability**: Downstream clients (like `analysis_server`) can continue to use the specific `FieldFormalParameterElement` if it's applicable to the unified parameter entity.
3.  **Encapsulated Logic**: The logical unification (deriving kind-specific properties from any fragment in the chain) is handled inside the analyzer, rather than shifting the burden to clients.

---

## 4. Implementation (In-Place Breaking Change)

### 1. Public API Updates (`pkg/analyzer/lib/dart/element/element.dart`)
Relax the `firstFragment`, `fragments`, `nextFragment`, and `previousFragment` types for `FieldFormalParameterElement`, `SuperFormalParameterElement`, `FieldFormalParameterFragment`, and `SuperFormalParameterFragment`.

### 2. Implementation Updates (`pkg/analyzer/lib/src/dart/element/element.dart`)
Relax the `nextFragment` implementation to return `FormalParameterFragmentImpl?` without the downcast.

### 3. Elements Creation Logic (`pkg/analyzer/lib/src/dart/element/element.dart`)

There are currently two code paths that create elements for formal parameter fragments, and **both** trigger instantiation based solely on the first fragment in the chain.

#### Path A: Initial Build from AST (Lazy)
When building from containing element models (e.g. `ElementBuilder`), fragment chaining is appended, but parameter elements are not constructed. Instead, they are built lazily on access via the `.element` getter on the parameter fragment:

```
// FormalParameterFragmentImpl
@override
FormalParameterElementImpl get element {
  if (_element != null) return _element!;
  
  FormalParameterFragment firstFragment = this;
  // ... walks backward to firstFragment ...
  
  return _createElement(firstFragment);
}
```
This calls into specific subclass overrides like `_createElement(firstFragment)` which instantiate their respective `ElementImpl` structures relying strictly on the introductory fragment kind.

#### Path B: Loading from Summaries (Eager)
During the bundle reading phase, `BundleReader` calls `.linkFragments()` on the enclosing executable element (e.g., `ConstructorElementImpl`, `MethodElementImpl`). This eventually delegates to `FormalParameterFragmentImpl._linkFragments`, which iterates through the **first** fragment's parameter list and creates parameter elements immediately:

```
// FormalParameterFragmentImpl._linkFragments
var firstFormalParameters = getFragments(fragments.first);
for (var fragment in firstFormalParameters) {
  switch (fragment) {
    case FieldFormalParameterFragmentImpl():
      FieldFormalParameterElementImpl(fragment);
    // ...
  }
}
```

---

## 5. Target Updates

To resolve the issue, both creation triggers must be updated to process the full list of supporting fragments. The element class selection should scan the full chain:
*   If **any** fragment in the chain is a `FieldFormalParameterFragment`, instantiate a `FieldFormalParameterElementImpl`.
*   If **any** fragment in the chain is a `SuperFormalParameterFragment`, instantiate a `SuperFormalParameterElementImpl`.
*   Otherwise, instantiate a `FormalParameterElementImpl`.

---

## 6. Alternatives Considered

### Single `FormalParameterElement`
Instead of retaining specific element subclasses (`FieldFormalParameterElement`, `SuperFormalParameterElement`), we could collapse them into a single `FormalParameterElement` type, representing the logical parameter position.

Specific information could be exposed via:
1.  **Flat Properties**: Adding nullable fields (e.g. `FieldElement? field`, `ParameterElement? superParameter`) directly into the base interface.
2.  **Nullable Sub-objects**: Adding a `FieldParameterInfo? fieldInfo` component containing specific data.
3.  **Polymorphic Details**: A sub-hierarchy for specialized parameter detail payloads.

#### Trade-offs:
*   **Pros**:
    *   Drastically simplifies element creation. There is only one parameter item per position in the signature, matching the runtime model more closely.
    *   Bypasses the need for selecting an Element type based on fragment presence.
*   **Cons**:
    *   **Significant Breaking Change**: Extensive use of `FieldFormalParameterElement` exists in the analyzer and `analysis_server` (fixes, refactorings). Migrating would be high-cost.
    *   **Consumer Burden**: Shifts the check `is FieldFormalParameterElement` to property inspection (e.g. `fieldInfo != null`), making client code less type-safe or more verbose.
    *   **No Decision Avoidance**: It does not eliminate the need to scan the full chain to decide on the "kind" of parameter; it simply shifts the decision from choosing an `Element` subclass to deciding which sub-object or properties to populate.
