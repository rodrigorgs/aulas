# Label Refactoring

This document outlines the refactoring of the `Label` node and its usages in the Dart analyzer AST. The goal is to replace `SimpleIdentifier` (which is an `Expression`) with a simple `Token` in places where the name is used purely for structural identification and not for evaluation.

## 1. Current State (Legacy Design)

Currently, a `Label` (both in declarations and in `break`/`continue` statements) uses a `SimpleIdentifier` to represent the name. Since `SimpleIdentifier` is a subclass of `Expression`, this implies that a label name is an expression, which is semantically incorrect. Labels are purely structural markers and do not evaluate to values or have types.

### Current Hierarchy and Usage

*   **`Label` (Declaration):**
    ```dart
    abstract final class Label implements AstNode {
      SimpleIdentifier get label;
      Token get colon;
    }
    ```
    The `declaredFragment` (or element) is currently retrieved by looking at the `SimpleIdentifier`'s element.

*   **`BreakStatement` & `ContinueStatement` (Usage):**
    ```dart
    abstract final class BreakStatement implements Statement {
      Token get breakKeyword;
      SimpleIdentifier? get label;
      Token get semicolon;
      AstNode? get target;
    }
    ```
    The reference to the label is also a `SimpleIdentifier`. Its resolved label binding is available via `node.label?.element`, while `target` independently stores the resolved jump destination AST node.

### Pain Points

1.  **Semantic Incorrectness:** `SimpleIdentifier` is an `Expression`. Using it for labels implies they have expression semantics (types, evaluation), which they do not.
2.  **Cluttered Expression Model:** Tools that analyze expressions (like searching for references, refactorings, or lints) have to explicitly filter out label identifiers because they appear in the AST as expressions.

---

## 2. New Design (Target State)

The new design splits declarations and references:

*   A declared `Label` stores its name as a simple `Token`.
*   A `break`/`continue` label reference becomes a dedicated wrapper node that stores both the `Token` and its resolved `LabelElement`.

This keeps label references out of the expression hierarchy without scattering their resolution state across the parent statement nodes.

### Detailed Structure

*   **`Label` (Changes):**
    ```dart
    abstract final class Label implements AstNode {
      Token get name; // Changed from SimpleIdentifier to Token
      Token get colon;
      
      LabelFragment? get declaredFragment; // Moved from SimpleIdentifier to the Label node itself
    }
    ```

*   **`LabelReference` (New):**
    ```dart
    abstract final class LabelReference implements AstNode {
      Token get name;
      LabelElement? get element;
    }
    ```

*   **`BreakStatement` and `ContinueStatement` (Changes):**
    ```dart
    abstract final class BreakStatement implements Statement {
      Token get breakKeyword;
      LabelReference? get label; // Changed from SimpleIdentifier?
      Token get semicolon;

      AstNode? get target; // Preserved: resolved jump destination AST node
    }
    ```
    *(Same changes apply to `ContinueStatement`.)*

---

## 3. Advantages

1.  **Semantic Accuracy:** Labels are no longer treated as expressions. They are accurately modeled as purely syntactic tokens.
2.  **Cleaner Expression Processing:** Visitors that process expressions do not see labels, reducing special-casing and potential bugs in lints or refactorings.
3.  **Node-Based Reference Model:** A label use remains a first-class AST node, so tooling such as element location, printing, and reference traversal can continue to work naturally on the reference itself.
4.  **Direct Resolution Access:** Resolution information for label bindings is stored directly on the reference node, while existing jump-target resolution on `BreakStatement.target` / `ContinueStatement.target` remains separate.

---

## 4. Implementation (In-Place Breaking Change)

As we are not doing incremental migrations for these structural modernizations, this change will be implemented as an **in-place breaking change**.

### Steps

1.  **AST Structure Update:** Modify `ast.dart` and regenerate code so that `Label` stores a `Token name`, and `BreakStatement` / `ContinueStatement` use `LabelReference? label` instead of `SimpleIdentifier?`.
2.  **Parser Adjustment (`AstBuilder`):** Update `AstBuilder` to create `Label` from the declaration token and to build `LabelReference` nodes for `break` / `continue` labels.
3.  **Resolution Visitor Update (`ResolverVisitor`):**
    *   For `Label`, create and attach the `LabelElement` directly to the `Label` node.
    *   For `LabelReference`, resolve its `name` to the active `LabelElement` and attach it to the reference node. Continue to compute `target` as the resolved jump destination AST node, as today.
4.  **Fix Internal Usages:** Update internal analyzer visitors (testing, highlights, lints, element location, source printing) to use the new declaration token and `LabelReference` node.
