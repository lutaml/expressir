# 04 — SHTOLO rule audit + corpus differential

Folds TODO.parity-ee 14's remainder.

- Walk `spec/fixtures/shtolo/annex-g-rules.md` (G.NM.1-2, G.1.1-10,
  G.2.1-7): mark every rule PASS/partial/✖ with a fixture per rule.
- G.1.6 dependently-instantiable output verified against the Annex G
  text (eeng ✖ there; the standard wins).
- name-munging policy (`_dot_` and friends): eeng ✖; standard wins.
- prune-pass reachability (unreachable subtype branches).
- corpus differential: every modules.lst module arm/mim, flat output
  diffed vs eeng :flat, divergences classified.
