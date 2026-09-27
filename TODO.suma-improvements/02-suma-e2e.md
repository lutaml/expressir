# 02 — Suma full-document E2E on the current stack

## Goal
One clean E2E run of an actual suma document build with expressir 2.4.24 +
metanorma-plugin-lutaml 0.7.53 + current metanorma gems, rendering a real
ISO 10303 module document to XML.

## Why now
The earlier full-render was blocked by the metanorma-document/relaton
0.2.x skew; that ecosystem has moved (metanorma-document 0.5.1, relaton
3.0 pre-alpha). The expressir side is proven current.

## Steps
- locate the suma build entry (~/src/mn/iso-10303 suma config or the
  metanorma-iso document that renders schema pages)
- bundle with current metanorma; render one module doc end to end
- capture XML diffs vs the last good render; if the relaton skew
  persists, name the exact unresolved constraint

## Acceptance
- a rendered module document, or a one-line statement of the precise
  upstream blocker with the failing constraint
