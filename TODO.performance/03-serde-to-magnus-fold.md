**Status: DESIGN — expressir-rs + ext; medium effort (~1-2 sessions)**

## Why

The ext builds a serde_json Value tree (full second copy of the
model), then walks it to build Ruby objects. Folding emission into
arena→magnus construction removes the intermediate: ~0.5s CPU at SRL
scale plus significant transient memory (the wire Value tree).

## Design

- Parameterize the model_json emitters over a `ValueSink` trait:
  `SerdeSink` (existing JSON shape — stays the single parity source)
  and `MagnusSink` (calls `Klass.instantiate` directly per node).
- The ext's `value_to_ruby` walker collapses into MagnusSink; wire
  parity is enforced by the existing quirk tests + corpus gates that
  run both sinks and compare.
- `parse_to_model_hash` keeps the serde path for tooling.

## Risk

Trait plumbing across 5 emitter files; generics vs dyn — prefer
`dyn ValueSink` first (perf delta likely negligible vs allocations
saved), measure before optimizing the dispatch.

## Gates

- Corpus + SRL byte parity; SRL cold compile −0.4s or better; peak
  RSS during batch down measurably.
