# 01 — Static type checking of expressions

The Checker resolves references (TODO.eengine/02/03); this task gives
it TYPES: full static checking of the expression and statement
language per ISO 10303-11 ch.12/13/8/9.

## Tiers (each ships)

1. Clause map: expression grammar ↔ ISO 10303-11 12.x productions ↔
   eeng check.lisp expression methods, with the typing rule for each
   (operand domains, result type). Table in this file before code.
2. Operator domains: arithmetic on the NUMBER family, logical on
   BOOLEAN/LOGICAL, relational polymorphism, string/binary ops,
   aggregate operators (INDEX/QUERY/SUM and friends).
3. Aggregates: element types through indexing/slicing, bounds vs
   literals where static, nested aggregates.
4. SELECT/ENUM membership: assignment compatibility, IN-of-enum,
   `x : t := expr` compatibility in CONSTANT/LOCAL/DERIVE initializers.
5. Statement flow: assignment compatibility, IF/CASE selector types,
   REPEAT control types, function RETURN type vs return statements.
6. WHERE/UNIQUE structural checks: expression boolean-ness, UNIQUE
   label uniqueness, rule FOR-entity containment for referenced
   attributes.

## Interface

`Checker#check_expression_types(schema)` emitting notes with eeng ids
where check.lisp has them, own ids (`:check_expr_*`) citing clauses
where it does not (mirror TODO.eengine/02's SELF-redeclaration
precedent).

## Acceptance

- Corpus-clean over the 265-file resource slice (foreign-blindness
  rule applies: unresolvable names skipped, not flagged).
- eeng differential for the expression checks eengine actually
  implements; standard wins on divergence.
