# 03 — Conformance: measure against the standard's own yardstick

## Parts (each ships)

1. Part 21 conformance corpus: extract the conformance-requirement
   examples from the detached ISO 10303-21 source (annexes + body
   worked examples) into fixtures; a gate spec runs the P21
   reader/validator over every positive fixture (clean) and every
   negative fixture (the intended note id, only).
2. Grammar-conformance harness: property-based generation from the
   ISO 10303-11 Annex A/B productions (finite fragments first:
   declarations, then expressions). Invariants: parse→format→parse
   idempotence, formatter output re-parses, ill-formed input rejected
   with a diagnostic (no silent recovery on the strict faces).
   Promoted to a nightly CI tier.
3. G.1.7 closure: the BASED_ON enumeration-chain corpus fixture —
   the last unaudited Annex G rule (annex-g-rules.md table tail).

## Acceptance

- `rake conformance` (or the spec tier) green; negatives fail with
  exactly the intended note, positives with zero notes.
