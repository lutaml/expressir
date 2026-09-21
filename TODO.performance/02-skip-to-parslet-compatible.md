**Status: DESIGN — needs the parsanol raw-tree API (01.4) or a walk-layer rewrite**

## Why

`to_parslet_compatible` normalization is a steady 12-14% of the parse
pipeline (normalize_bench). The core path does not need parslet
shapes; only the walk layer (hash_get/children_of in expressir-rs
model_json) consumes them.

## Two routes

1. **Preferred — parsanol raw-tree API** (TODO.performance/01.4):
   document/stabilize the tagged arena tree (`:sequence`/`:repetition`
   shape); port `walk.rs` + `model_json/*` to it; delete the
   normalization call from `ParsedTree::parse`.
2. **Without upstream**: keep a raw-tree branch of the walk layer in
   expressir-rs (`model_json_raw`) behind a cargo feature, fed by
   `parser.parse()` without normalize; parity-gate against the
   normalized path over the full corpus.

## Gates

- Wire parity: corpus + SRL to_hash byte-identical (both routes).
- Speedup ≥ 8% end-to-end cold compile, else not worth the second
  walker.

## Notes

The arena keys stay verbatim grammar atom names (tOPTIONAL vs Ruby's
snake_case `:t_optional`) — the raw walker must keep that mapping
table; it exists implicitly in walk.rs today.
