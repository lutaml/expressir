# 02 — The evaluator: run EXPRESS

The SOTA-defining capability: execute the language. Functions and
WHERE rules evaluated over Part 21 populations — the line between a
toolchain that reads EXPRESS and one that runs it. No open
implementation has this (eengine's --validate is the cautionary tale).

## Steps (each ships)

1. Value model + expression core: IMMUTABLE value classes (NUMBER
   family, STRING/BINARY, LOGICAL, enumeration, aggregate arrays as
   frozen structs), literal → value, pure expression evaluation
   (operators per 01's domain table), environmental lookup through a
   Scope chain. Interface: `Expressir::Eval.expression(ast, env)`.
2. Function interpreter: parameter binding (incl. VAR semantics),
   LOCALs with initializers, IF/CASE/REPEAT/compound/RETURN, ESCAPE/
   SKIP, recursion with depth guard. Builtin set A (math/string,
   ISO 10303-11 15.x): SIN..BLENGTH class.
3. Instance-aware builtins: TYPEOF, USEDIN, EXISTS, QUERY (lazy
   binding), attribute access through the model's computation layer
   (Entity#all_explicit_attributes, supertype_closure, redeclaration
   resolution — TODO.eengine/03), complex-instance (GROUP) access.
   Builtin set B (instance/aggregate: SIZEOF, HIBOUND..).
4. WHERE-rule checking: `Expressir::Rules.check(population, schema)`
   → per-instance, per-rule results with the failing subexpression
   path. Wraps the P21 Validator's structural tiers (TODO.eengine/06)
   into semantic validation.
5. Differential: eengine where its validate answers; property-based
   round-trips otherwise (evaluate a rule against a corpus population,
   cross-check pure-Ruby reference impls for builtins). If hot loops
   dominate, drop the evaluation core to expressir-rs (option B) —
   gate on measured need, not speculation.

## Design constraints

- The evaluator consumes the SAME model the parser produces — no
  parallel AST.
- Errors are notes/exceptions carrying node + path, never exit.
- Determinism: no reliance on hash order (corpus QA depends on it).

## Acceptance

- Annex-level worked examples (function bodies from ISO 10303-11)
  evaluate to the documented results.
- WHERE evaluation over the Annex H population: every rule provably
  passes; a seeded-fault population fails the intended rule only.
