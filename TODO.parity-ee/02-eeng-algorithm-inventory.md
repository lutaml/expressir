# 02 — eeng algorithm inventory: what they do vs what we do differently

**Status: NOT STARTED**

## Goal

A written comparison of every eeng kernel/plugin algorithm against
expressir's current behavior — the "what we do differently" audit the
SHTOLO work depends on (ordering, renaming, visibility semantics).

## Method

Walk the sources file by file and record, per algorithm: eeng's data
flow (session → schemata1/schemata2, passes), semantics, and the
expressir counterpart (or gap). Files (kernel/ unless noted):

- **Load scheduling**: `plugins/p11/schedule-load.lisp`,
  `schedule-interfaces.lisp`, `schedule-resolve.lisp` — two-phase
  parse + interface scheduling; compare our batch + resolver +
  `wire_parents`.
- **Resolution**: `resolve-interface.lisp` (USE resolves only
  type/entity; REFERENCE resolves constant/entity/function/procedure/
  type), `resolve-object.lisp`, `resolve-ref.lisp`, `references.lisp`,
  `schema-search.lisp` — vs our `ResolveReferencesModelVisitor`
  (base_path stamping only!) and `Schema#interfaced_items`.
- **Entity computations**: `compute-inheritance.lisp`,
  `supertypes.lisp`, `attributes.lisp`, `explicit-attrs.lisp`,
  `derive-attrs.lisp`, `inverse-attrs.lisp`, `find-attribute.lisp`,
  `partitions.lisp`, `unique-rules.lisp`, `where-rules.lisp` — we have
  none of these as materialized computations.
- **Session/surgery**: `session.lisp` (schemata1/2, compare sets),
  `add-declaration.lisp`, `remove-declaration.lisp`, `copy-object.lisp`,
  `cleanup.lisp`, `cleanup-interface.lisp`, `reset-session.lisp`.
- **Writers**: `plugins/p11/wo-{p11,pretty,flat,list,lexp,smrl-xml}.lisp`.
- **Other readers**: `reader-step.lisp`/`reader-data.lisp` (Part 21),
  `parse-module-lxml.lisp`, `reader-xml.lisp`; `plugins/p21`,
  `plugins/xref`.

## Output

`TODO.parity-ee/parity-matrix.md`: algorithm × {eeng file, semantics
summary, expressir equivalent, differences, port cost}. Feeds tasks
05-10; the differences column is the deliverable the user asked for.

## Acceptance

Matrix covers all 84 kernel files + p11/p21/xref plugins with an
explicit same/different/gap verdict each.
