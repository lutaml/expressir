# Parity with Express Engine (eeng) — SHTOLO and algorithms

**Status: PLANNED (2026-09-21)**

## Mission

1. **SHTOLO** (expressir#32): SHort-TO-LOng — generate ISO 10303-11:1994
   "long form EXPRESS" (one self-contained schema) from the STEPmod
   multi-schema structure (edition 2: shared files, USE FROM /
   REFERENCE FROM). The normative conversion rules are
   **ISO 10303-11:2004 Annex G** — local sources:
   `~/src/mn/iso-10303-11/sources/sections/ag-single-schema.adoc`.
2. **Concatenation** (expressir#247, metanorma/iso-10303#539): the SHTOLO
   precursor — a dependency-closure concatenation of all interfaced
   schemas into one publication artifact (`.exp`), plus SMRL index.
3. **Validation** of both, against the reference implementation:
   Express Engine (`~/src/external/exp-engine-engine`, Common Lisp),
   whose `qualify.sh` runs the full operation catalog over the exact
   SMRL corpus we already load (`resources.lst`/`modules.lst` ==
   our SRL manifests).

## Reference implementation map

| eeng source | operation (qualify.sh) | task |
|---|---|---|
| `plugins/p11/wo-pretty.lisp` | Pretty Print `.exp` + compare | 08 |
| `plugins/p11/wo-flat.lisp` + `run-op :flat` | **Flatten to long form** | 05 |
| mode `:concatenated` (`kernel/engine.lisp`) | **Concatenate schema** | 04 |
| `plugins/p11/wo-list.lisp` | List declarations | 09 |
| `plugins/p11/wo-smrl-xml.lisp` | SMRL index XML | 09 |
| `kernel/dot-graph.lisp` | Dot interface graph | 10 |
| `kernel/check.lisp` (835 lines) | semantic checks | 07 |
| `plugins/p11/schedule-*.lisp`, `kernel/resolve-interface.lisp` | load/resolution scheduling | 06 |
| `kernel/compute-inheritance.lisp`, `supertypes.lisp`, `derive-attrs.lisp`, `inverse-attrs.lisp` | entity computations | 02/07 |

## What we already have (expressir)

Compiled schema set (batch + EXSCS1 artifact + overlays), repository
indexes + reference graph (37.7k subtype edges, interfaces, closures),
`Schema#interfaced_items`, resolver, formatter (clean/hyperlink),
`RepositoryValidator`, Part 21 parser = **not started** (see 02).

## Task index

01 Annex G rule extraction · 02 eeng algorithm inventory (what we do
differently) · 03 eeng oracle harness · 04 concatenation (#247) ·
05 SHTOLO longform flatten (#32) · 06 interface scheduling parity ·
07 semantic checks port · 08 pretty-print round-trip gate ·
09 SMRL index + listing · 10 interface dot graph
