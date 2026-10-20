# TODO.sota — the SOTA program (vision)

Expressir is the open compiler-infrastructure layer for ISO 10303
information models: a faithful, programmable model of EXPRESS
(ISO 10303-11), the standard transformations between the language's
normative forms (Annex G longform, Part 21, Part 28/XML, XSD, MIM
mappings), and CI-grade guarantees for the standards corpus. The
eengine-parity program (TODO.eengine, done) made it the ecosystem's
reference toolchain. This program takes it to SOTA — the point where
Expressir is not just the ecosystem's parser but its *engine*, its
developer platform, and its interoperability hub.

## Execution order and status

| n | task | tier | status |
|---|------|------|--------|
| 01 | static type checking of expressions | semantics | done (tiers 1-6; :check_expr_operand_domain/:check_expr_initializer_type/:check_expr_assignment_type/:check_expr_return/:check_expr_where_boolean/:check_expr_unique_duplicate; corpus 261-slice 0 notes) |
| 02 | evaluator — run EXPRESS (functions, WHERE rules over populations) | execution | todo |
| 03 | conformance (Part 21 conformance corpus, property-based grammar harness, G.1.7 closure) | rigor | done (P21 annex corpus + negative ladder-exclusion gate; generated round-trip harness + nightly corpus tier + rake conformance; every Annex G rule audited) |
| 04 | LSP + incremental platform | platform | todo |
| 05 | interop exports (JSON Schema, OWL/RDF) | interop | todo |
| 06 | dialect awareness (1994 vs 2004, amendments) | semantics | todo |
| 07 | reference artifacts (grammar cross-walk, published guides) | reference | todo |

Dependency shape: 02 consumes 01's type tiers loosely (interleave by
tier when a check needs execution semantics). 04 scaffolds
independently; its diagnostics richness grows with 01. 03/05/06/07 are
independent.

## Sources

- ISO 10303-11 text: `~/src/mn/iso-10303-11/sources/sections/`
  (expressions ch.12, statements ch.13, data types ch.8, rules 9.x,
  Annex A/B productions).
- Part 21: `~/src/mn/iso-10303-detached-docs/sources/iso-10303-21/`.
- stepmod corpus: `~/src/mn/iso-10303-stepmod/data/` (SRL/BOM/module
  manifests; the 265-file <250KB resource slice is the fast
  differential set).
- eengine oracle: `~/bin/eengine` — schema ops need
  `-MODE RESOURCE -STEPMOD ~/src/mn/iso-10303-stepmod`;
  --validate/--xref are broken on bare p11 (never build on them).
- leptris runs FFI-fallback on this box; no spec may assume the native
  engine.

## Standing rules

- Where eengine and ISO 10303-11 disagree, the standard wins; classify
  the divergence in the differential output, never copy silently.
- Every ported check keeps its eengine note id (where one exists) and
  cites its ISO 10303-11 clause.
- Semantics land in Ruby; parse-adjacent and graph-scale hot paths may
  land in expressir-rs (gated per task).
- All model (de)serialization goes through lutaml-model mappings —
  never hand-rolled to_h/from_h.
- Specs use real model instances, never doubles; rubocop clean is a
  merge gate; the suite runs in chunks on this box (full single-process
  runs OOM).
