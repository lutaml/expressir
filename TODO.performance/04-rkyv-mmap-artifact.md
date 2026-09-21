**Status: BACKLOG — v2 of the EXSCS1 artifact**

## Why

v1 bincode decodes ~1s for SRL in Rust before hydration; mmap-able
zero-copy layout (rkyv) makes artifact "loading" free and graph-only
consumers (validation engine, Tier-2 drops) never deserialize at all.

## Design

- Same envelope, new magic `EXSCS2`: rkyv-archived per-file wires,
  overlays (remarks/refs), and the graph tables of
  TODO.performance/05.
- Reader: mmap + validate digests; hydrate per file from the archived
  wire (single translate pass) for the Ruby path; native adjacency
  queries in Rust for graph-only callers.
- Migration: write both during a transition; read v2 if present.
  Do not bump v1 semantics — keep byte-parity gates on the Ruby path.

## Gates

- Warm start < 3s at SRL with full hydration; graph-only queries
  return with zero deserialization (measure with a Rust-side
  example).
