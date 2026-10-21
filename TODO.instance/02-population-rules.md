# 02 — Population-scale rule engine

TODO.sota/02 made rules runnable; this task makes them runnable over
whole populations, at corpus scale, with the cross-instance semantics
ISO 10303-11 requires.

## Parts (each ships)

1. Compiled rules: parse and resolve each WHERE / UNIQUE / global rule
   once per schema edition; apply the compiled form to many instances.
   The Ruby evaluator stays the semantics home — the native path is a
   measured-need escalation only (standing rule), with a benchmark to
   justify any move.
2. UNIQUE rules: per entity, each UNIQUE label's expression evaluated
   across the whole population with duplicate detection; labels
   combining attributes and aggregates handled; self-referential
   population patterns (instances referencing instances of the same
   entity) are just population lookups.
3. Global rules: `RULE ... FOR (e1, e2)` — the FOR set is all
   instances of the named entities; the rule body evaluates once per
   rule over that population (SIZEOF/QUERY/USEDIN over the whole
   population, not per instance); violation only on proven false
   (9.4); indeterminate is not a violation.
4. Derived and inverse consistency: derived slots must be `*` per the
   Part 21 mapping (validator has it); DERIVE expressions recomputed
   and cross-checked where a value is present; INVERSE attributes
   validated as population-consistent (every inverse view of the
   explicit relation is materializable).
5. Scale and determinism: an SRL-scale synthetic population (10^5
   instances) rule-checked within a documented runtime budget,
   published as a rake benchmark; identical population + schema
   edition → byte-identical report.

## Acceptance

- Spec examples per rule (firing + clean) citing 9.4 / 9.2.x.
- Annex H population: every WHERE rule provably passes at engine
  level; the seeded-fault population fails exactly the intended rule
  and no other.
- UNIQUE: a duplicated label pair is found regardless of file order;
  global rule: an aggregate violation (e.g. a FOR-set size rule) is
  caught once, with instance evidence.
- The benchmark artifact records the 10^5-instance run on this box.
