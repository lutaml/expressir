**Status: BACKLOG — expressir; Metanorma Tier 1 render path**

## Why

Warm start hydrates every schema (~2.5s at SRL, ~15-20s projected at
SMRL) though a document renders a handful. Liquid drops need only the
referenced schemas; graph queries (05) need none.

## Design

- `Set` reader hydrates on demand: `model_at(index)` already lazy per
  call; add a `Repository`-compatible facade that hydrates a schema
  on first access (path table tells which file holds it — needs 05).
- Overlays re-keyed per file (they already are — structural keys are
  per model: `model[i]/...`; lazy hydration must renumber or key by
  wire_path instead of index — CHOOSE wire_path keys in this task).
- Resolver semantics: cross-file references into unhydrated schemas
  need the refs overlay (already repository-wide) + graph lookups.

## Gates

- SRL warm with 5 rendered schemas < 1.5s; full-set to_hash still
  identical when all schemas are eventually touched.
