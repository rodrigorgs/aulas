# Resolution Affected By Context Type

This document describes the analyzer flag `ExpressionImpl.isResolutionAffectedByContextType`.

The flag exists so later stages can distinguish these two situations:

```text
List<int> x = [f()];
```

```text
var x = [f()];
```

If removing the surrounding context type can change how an expression resolves, then the original expression is marked with `isResolutionAffectedByContextType: true`.

The motivating consumer is lints such as `omit_local_variable_types`, but the mechanism is analyzer-owned and is not specific to any single lint.

Motivated by [sdk#63084](https://github.com/dart-lang/sdk/issues/63084), this flag lets the analyzer expose whether removing context could change expression resolution.

## Contract

For an expression `e`, the flag means:

> The resolved form of `e` depends on its context type.

In practice this means that removing or changing the imposed context type could change at least one of:

- the chosen declaration or member
- inferred type arguments
- the static type of the expression
- the static type of a context-sensitive subexpression

The flag does **not** mean merely that a context type existed. It is intended to capture semantic effect, not syntactic position.

That distinction matters for examples such as:

```text
T id<T>(T x) => x;

int a = id(0);   // context exists, but is not needed
int b = id();    // invalid here, but if a similar case inferred from context,
                 // context would matter
```

The first kind of case should stay unmarked if the arguments already determine the result.

## Storage

The flag is stored on `ExpressionImpl`.

It defaults to `false` and is set during resolution by the components that actually consume contextual information, or by wrapper expressions that propagate the fact from their children.

## Where The Flag Originates

These are the main places where the analyzer creates the signal instead of merely propagating it.

### Generic invocation inference

Generic invocation inference is the most important source.

If downward context changes inferred type arguments, the invocation is marked. This is implemented in `invocation_inferrer.dart`.

Representative examples:

```text
T f<T>() => throw 0;

int x = f();          // significant
int y = f<int>();     // not significant
```

The same idea applies to:

- ordinary method invocations
- function-expression invocations
- instance creation with inferred type arguments
- partial inference, where arguments determine some type parameters and context determines the rest

### Dot shorthand

Dot shorthand resolution depends entirely on the imposed context type, so successful resolution marks the shorthand expression.

This is handled in:

- `method_invocation_resolver.dart`
- `property_element_resolver.dart`
- `instance_creation_expression_resolver.dart`

Examples:

```text
C x = .new();
E y = .value;
I z = .factory();
```

### Implicit instantiation of generic function values

When a generic function value is converted to a non-generic function type using context, the inserted function-reference node is marked.

This includes:

- plain identifiers
- prefixed identifiers
- property accesses
- constructor tear-offs
- implicit call references

The relevant logic is spread across:

- `resolver.dart`
- `constructor_reference_resolver.dart`

### Empty collection literals

An empty list, set, or map literal may get its element types entirely from context. In those cases the literal itself is marked.

This logic lives in `typed_literal_resolver.dart`.

Examples:

```text
List<int> a = [];
Set<String> b = {};
Map<int, String> c = {};
```

### Context-sensitive integer literals

An integer literal in `double` context is a special case in the type system. When this rule changes the literal's static type from `int` to `double`, the literal is marked.

This is implemented in `static_type_analyzer.dart`.

Example:

```text
double x = 0; // the integer literal is significant
```

## Propagation

Many expressions do not consume contextual typing themselves, but they should still report that their own resolution was affected because one of their children was.

In these cases the analyzer propagates the flag upward.

### Collection literals

For non-empty collection literals, the flag bubbles from significant elements to the containing literal.

This includes:

- plain elements
- map entries
- spreads and null-aware spreads
- null-aware elements
- `if` elements
- `for` elements

This propagation is implemented in `typed_literal_resolver.dart`.

Example:

```text
List<int> x = [f()];
```

Here the interesting part is usually `f()`, but the list literal is also marked because its resolved form depends on that child.

### Record literals

Record literals follow the same rule: if any field expression is marked, the record literal is marked.

This is implemented in `record_literal_resolver.dart`.

### Wrapper expressions

Several wrapper forms propagate the flag from a significant child:

- parenthesized expressions
- prefix expressions such as unary `-`
- `await`
- conditional expressions
- `??`
- switch expressions

These propagation points live in:

- `static_type_analyzer.dart`
- `prefix_expression_resolver.dart`
- `binary_expression_resolver.dart`
- `resolver.dart`

Propagation is intentionally shallow in meaning:

> if a child changed because of context, the enclosing expression also changed because of context

## What The Flag Is Not

The flag is not intended to mean any of the following:

- "this expression had a context type"
- "this expression is in a typed location"
- "this expression participates in inference somehow"
- "this expression would be illegal without context"

The flag is about the resolved result, not about whether contextual typing was available in the abstract.

This is why the test suite contains many negative pairs such as:

- context exists, but explicit type arguments make it irrelevant
- context exists, but argument inference already determines the result
- context exists, but the expression already has the same static type without it

## Serialization

The flag must survive the summary round-trip.

Without that, the analyzer can produce different answers for:

- linked ASTs that are still in memory
- ASTs reconstructed from summary bytes

This became observable in summary element tests. The fix is in:

- `ast_binary_writer.dart`
- `ast_binary_reader.dart`

Expression serialization now stores both:

- `staticType`
- `isResolutionAffectedByContextType`

This keeps `keepLinking` and `fromBytes` behavior aligned.

## Tests

The main semantic coverage lives in `is_resolution_affected_by_context_type_test.dart`.

The test suite is organized around:

- the source of context; examples include local initializer, return, `yield`, `await`, and `FutureOr`
- the expression kind; examples include generic invocation, collection literal, record literal, constructor tear-off, and integer literal
- whether context should matter; `significant` vs `notSignificant`

The summary round-trip is covered by summary element tests such as `class_test.dart`.

## Current Scope

This flag is intended to be a reliable analyzer fact, not a lint-specific heuristic.

It does not try to model an abstract notion of "all contextual influence" in the type system. Instead, it records whether changing or removing the imposed context type can change the resolved form of an expression in ways that downstream tools care about.

When new contextual typing features are added, the right question is usually:

> If the surrounding context type changed or disappeared, would the resolved form of this expression change in a way that downstream tools care about?

If yes, the new code path should either:

- set `isResolutionAffectedByContextType` directly
- propagate it from the affected child expression

So the contract is strong, but completeness depends on keeping new context-sensitive resolution paths integrated with this flag.
