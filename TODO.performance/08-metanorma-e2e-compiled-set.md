**Status: PARTIALLY BLOCKED UPSTREAM (pubid-iso#285 for the v3 ladder)**

## What

Render the SRL collection (metanorma-srl.html.yml manifest) with
EXPRESSIR_COMPILED_SET pointing at the artifact; byte-diff document
outputs cold vs warm; measure wall time at collection scale.

## State

- Single-document e2e proven (description_assignment): document.xml
  and presentation.xml byte-identical cold vs warm; HTML differs only
  in per-run anchor UUIDs.
- Stack: the 0.2.12 branch ladder renders today; the document-main
  (v3) ladder is blocked on pubid-iso#285 (year-month dates, bare TC
  references) — one ID-shape fix from working.

## Steps

1. pubid-iso#285 lands (or patch branch) → v3 ladder render green.
2. `EXPRESSIR_COMPILED_SET=<srl.exscs> suma build metanorma-srl.yml`.
3. Diff cold/warm outputs across all documents; record times
   (expect schema-loading share of the build to nearly vanish).
