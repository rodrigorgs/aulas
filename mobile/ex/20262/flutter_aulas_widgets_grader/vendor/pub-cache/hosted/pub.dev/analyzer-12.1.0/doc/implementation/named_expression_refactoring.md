# Refactoring NamedExpression to NamedArgument

This document outlines the structural refactoring of `NamedExpression` into `NamedArgument`. In the current AST, `NamedExpression` is treated as a standard expression. This is a semantic inaccuracy - a named argument marker like `foo: 1` has no type or value outside of a method invocation. 

By removing its `Expression` subtyping and flattening its relationship with parameter names (removing the overloaded `Label` node), we decouple parameter naming from expression evaluation and establish a unified model for `ArgumentList`.

## 1. Current State (Legacy Design)

Currently, a `NamedExpression` (e.g., `foo: 1`) is classified as an `Expression`. This means it implements `Expression`, which is semantically incorrect outside of a function call. It can theoretically be placed in a binary expression or if statement (e.g. `x + foo: 1`), which is a flaw.

Furthermore, `ArgumentList` is a `NodeList<Expression>`, which treats positional and named arguments as uniform elements, forcing us to use `Expression` as a base type.

### Legacy Hierarchy

*   **`NamedExpression` (Legacy):**
    ```dart
    abstract final class NamedExpression implements Expression {
      Label get name; // Returns a Label node
      Expression get expression;
    }
    ```

---

## 2. New Design (Target State)

The new design introduces a generic **`Argument`** interface to represent any syntactic element of an argument list.

-   **`Expression`** implements `Argument`. Therefore, any standard expression acts as a **Positional Argument** without requiring a wrapper node.
-   **`NamedArgument`** (replacing `NamedExpression`) implements `Argument` but **not** `Expression`.

This cleanly separates parameter naming from expression evaluation while keeping the tree flat and efficient.

### Detailed Structure

*   **`Argument` (New):**
    ```dart
    abstract final class Argument implements AstNode {
      Expression get argumentExpression; // Unified access to the evaluation value
      FormalParameterElement? get correspondingParameter; // Unified access to resolution
    }
    ```

*   **`Expression` (Changes):**
    ```dart
    abstract final class Expression implements Argument {
      @override
      Expression get argumentExpression => this; // Returns self as a positional argument
      
      @override
      FormalParameterElement? get correspondingParameter; // Keeps its current implementation (for ArgumentList, IndexExpression, and BinaryExpression)
    }
    ```

*   **`NamedArgument` (New, replaces `NamedExpression`):**
    ```dart
    abstract final class NamedArgument implements Argument {
      Token get name; // Direct parameter name as a Token
      Token get colon; // Direct access to the colon
      @override
      Expression get argumentExpression; // The value
      // `correspondingParameter` is computed from the containing `ArgumentList`,
      // matching how positional arguments are resolved.
    }
    ```

*   **`ArgumentList` (Changes):**
    ```dart
    abstract final class ArgumentList implements AstNode {
      NodeList<Argument> get arguments; // Changed from NodeList<Expression>
    }
    ```

---

## 3. Advantages

1.  **Semantic Accuracy:** `NamedArgument` is no longer treated as an `Expression`. It is accurately modeled as an argument.
2.  **No Positional Wrapper Constraint:** By making `Expression` implement `Argument`, we avoid creating a separate `PositionalArgument` wrapper node. The tree remains flat and efficient.
3.  **Strict Typing:** A `NamedArgument` cannot be used where an `Expression` is expected (like inside binary expressions). It is restricted to `ArgumentList` bindings.
4.  **Single-Responsibility for `Label`:** Re-using `Label` in `ArgumentList` is gone. `Label` becomes strictly about control-flow markers.
5.  **Unified Value and Resolution Access:** Exposing `.argumentExpression` and `.correspondingParameter` on the base `Argument` interface allows tools and visitors to access the argument's value and resolution uniformly, without type-checking.

---

## 4. Design Philosophy & Precedents

### The `CollectionElement` Idiom

This "crossing beams" pattern (where a broad class like `Expression` implements a narrow interface like `Argument`) has a direct precedent in the analyzer AST: **`CollectionElement`**.

In Dart collection literals (like `[1, if (cond) 2, ...spread]`), nodes can be pure expressions, control-flow statements, or spreads. To model this, the `NodeList` in `ListLiteral` uses `NodeList<CollectionElement>`.

Instead of wrapping pure expressions in a `PositionalCollectionElement` node, the AST simply makes **`Expression` implement `CollectionElement`**. This allows pure expressions to be placed directly inside `ListLiteral.elements` without wrapping, saving memory and tree depth.

Our **`Argument`** proposal follows this exact structural blueprint.

### Resolution Compatibility

This refactoring is primarily about modeling arguments correctly in the AST.
Resolution APIs such as `correspondingParameter` are a compatibility constraint
on the design, not the main motivation for it.

In particular:
- explicit invocation arguments should expose `correspondingParameter` through
  the new `Argument` abstraction
- existing `Expression.correspondingParameter` behavior for implicit-argument
  forms (such as operators and index expressions) should continue to work

This keeps the refactoring semantically focused while preserving existing
resolution capabilities.

### The `RecordLiteralField` Analogy

The same design principles apply to `RecordLiteral` fields. In `master`, a `RecordLiteral` holds its fields in a `NodeList<Expression>`. To accommodate the change where `NamedArgument` is no longer viewable as an `Expression`, we can define a specific contextual role and a separate syntactic type for record literals, rather than overloading `Argument` (which is used for invocations).

-   **`RecordLiteralField` (Contextual Role):** Zero-cost positional fields by having `Expression` implement standard `RecordLiteralField`.
-   **`RecordLiteralNamedField` (Syntactic Node):** A specific node class for `name: expr` inside a record literal.

This matches how `RecordTypeAnnotation` fields are named in the AST (e.g., `RecordTypeAnnotationNamedField`, following the `<FeatureName><Type>Field` pattern). This keeps the literal AST exactly parallel to the type annotation AST.

---

## 5. Syntactic Types and Contextual Roles

This refactoring distinguishes between two different kinds of relationships in
the AST: **syntactic types** and **contextual roles**.

### Syntactic Types

A syntactic type describes what a node structurally is in the grammar.

Examples:
- `Expression`
- `Statement`
- `Declaration`
- `TypeAnnotation`

Syntactic types form the primary AST hierarchy. They are the hierarchy used by
generic visitors such as `GeneralizingAstVisitor`.

### Contextual Roles

A contextual role describes how a node is used inside some enclosing construct.

Examples:
- `Argument` inside an `ArgumentList`
- `CollectionElement` inside a collection literal

A contextual role does not define a second general-purpose visitor hierarchy.
Instead, it provides a typed view of what kinds of nodes are valid in a
particular container.

This allows the AST to model constructs such as:
- an `Expression` acting as an `Argument`
- an `Expression` acting as a `CollectionElement`
- a `NamedArgument` acting as an `Argument` without also being an `Expression`

### Visitor Policy

`GeneralizingAstVisitor` follows syntactic-type relationships only.

It does not generalize through contextual-role interfaces. In particular:
- introducing `Argument` does not imply a `visitArgument` generalization layer
- contextual roles are not part of the automatic generalization chain

This means that role-oriented handling should be implemented explicitly by
clients, rather than inferred from generic visitor generalization.

### Existing `visitCollectionElement`

The analyzer currently exposes `visitCollectionElement` in
`GeneralizingAstVisitor`.

Under the policy above, this is no longer considered the correct model.
`CollectionElement` is a contextual role, not a syntactic type, so it should not
participate in generic visitor generalization.

Therefore, this refactoring intentionally removes `visitCollectionElement` from
the generalization chain.

This change is treated as part of the same architectural cleanup:
- `Argument` will not gain a corresponding generalization layer
- `CollectionElement` will no longer retain one

### Consequences for This Refactoring

This policy supports the following design choices:
- `Expression` implements `Argument`, so positional arguments remain zero-cost
- `NamedArgument` implements `Argument`, but not `Expression`
- `ArgumentList.arguments` becomes `NodeList<Argument>`
- no `PositionalArgument` wrapper node is introduced

This keeps the tree semantically cleaner without adding wrapper-node overhead.

---

## 6. Implementation (In-Place Breaking Change)

This change will be an **in-place breaking change** due to its scale and impact. It will be implemented in a major version upgrade.

### Steps

1.  **Introduce `Argument` interface.**
2.  **Reparent `Expression`** to implement `Argument`. Add the `argumentExpression` getter returning self. Lift `correspondingParameter` up.
3.  **Convert `NamedExpression` to `NamedArgument`** (making it implement `Argument` only). Flatten its children (`Token name`, `Token colon`).
4.  **Update `ArgumentList`** to use `NodeList<Argument>`.
5.  **Fix all internal visitors** (searching, highlights, lints, testing) to expect `Argument` in `ArgumentList` and process `NamedArgument` and standard `Expression`s accordingly.

### API / Impl Mapping

In the analyzer AST, public API interfaces generally have corresponding
implementation-side `...Impl` types. This refactoring preserves that pattern.

However, it draws a distinction between syntactic-type implementations and
contextual-role implementations:

- **Syntactic types** use `...Impl` classes and participate in the primary
  superclass chain.
- **Contextual roles** use `...Impl` mixins and do **not** participate in the
  primary superclass chain.

This means:
- `ArgumentImpl` should be introduced as a mixin.
- `CollectionElementImpl` should be converted into a mixin.
- `ExpressionImpl` should remain a class in the syntactic hierarchy, while
  mixing in both contextual roles.

Illustratively:

```text
base mixin ArgumentImpl on AstNodeImpl implements Argument {
  ExpressionImpl get argumentExpression;

  @override
  InternalFormalParameterElement? get correspondingParameter {
    var parent = this.parent;
    if (parent is ArgumentListImpl) {
      return parent._getStaticParameterElementFor(this);
    }
    return null;
  }
}

base mixin CollectionElementImpl on AstNodeImpl implements CollectionElement {}

sealed class ExpressionImpl extends AstNodeImpl
    with CollectionElementImpl, ArgumentImpl
    implements Expression {
  @override
  ExpressionImpl get argumentExpression => this;
}

final class NamedArgumentImpl extends AstNodeImpl
    with ArgumentImpl
    implements NamedArgument {
  @override
  final Token name;

  @override
  final Token colon;

  @override
  final ExpressionImpl argumentExpression;

  NamedArgumentImpl({
    required this.name,
    required this.colon,
    required this.argumentExpression,
  });
}
```

The important point is that contextual roles are represented on the
implementation side, but only as mixins. They are available for shared code and
typing, without defining visitor generalization or the primary AST inheritance
shape.

### `correspondingParameter` Placement

`correspondingParameter` is an important constraint on the implementation, but
it should follow the AST design rather than define it.

`ArgumentImpl` should provide the shared implementation for explicit
`ArgumentList` membership.

`ExpressionImpl` should extend that behavior with its existing non-argument-list
cases, such as:
- index expressions
- binary operators
- assignment expressions
- other implicit-argument forms already supported today

This keeps the `Argument` contract uniform while preserving the existing
behavior of `Expression.correspondingParameter` outside explicit argument lists.
