# 04 — LSP + incremental platform

Make Expressir IDE-grade. The resolution/checking machinery is the
hard part and it exists; this task wires it to a language server.

## Parts (each ships)

1. Scaffold: `expressir-lsp` (solo binary or gem — decide by the
   metanorma toolchain's needs) speaking stdio LSP 3.17: initialize,
   diagnostics push, document symbols.
2. Diagnostics: Checker notes as publishDiagnostics with model-node
   → LSP range mapping (NodePositionIndex exists).
3. Navigation: definition (ScopeResolver + the USE/REFERENCE ladder +
   alias map), references, document/rename — rename updates the
   model in place and re-emits via the Formatter (the compare/patch
   engine provides the structural diff safety net).
4. Hover: PrettyFormatter excerpt of the target declaration + its
   remarks.
5. Incremental: document-open/parse via the expressir-rs core path
   when available (parsanol incremental machinery); fallback full
   reparse. Cold-open target: SRL-scale schema set interactive on
   this box.

## Acceptance

- A live editor session on the stepmod corpus: diagnostics on open,
  go-to-definition across a USE ladder, rename across two schemas
  with the diff verified by SchemaCompare.
