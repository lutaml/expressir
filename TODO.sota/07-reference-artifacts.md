# 07 — Reference artifacts: the citable Expressir

The academic endgame — make the implementation provable and citable.

## Parts (each ships)

1. Grammar cross-walk: rule-by-rule table, parsanol grammar rule ↔
   ISO 10303-11 Annex A/B production, with divergences (extensions,
   recoveries) classified — rendered into docs/ and kept in sync by a
   spec that fails when a grammar rule lacks a row.
2. Property-based corpus testing as a published nightly tier (03's
   harness, trended: parse rate, diagnostic rate, idempotence rate).
3. Published guides: one doc per subsystem (checker + note-id
   catalog, shtolo + annex-g-rules linkage, p21, evaluator, lsp),
   generated where possible from the model (note-id catalog from the
   Checker's constants).

## Acceptance

- docs/ builds with the cross-walk and guides; the sync spec is part
  of the default suite.
