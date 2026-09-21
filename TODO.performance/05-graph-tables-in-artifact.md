**Status: BACKLOG — expressir-rs + expressir; unblocks Tier-2 drops and Part 21 validation**

## Why

The item graph (60,338 nodes; 37,708 subtype + 4,391 interface-item +
43,281 attribute-type edges at SMRL scale) is deterministic; today it
is derivable only after full hydration + resolution. Precomputing it
in Rust at compile time makes it a property of the artifact.

## Design

- Compile step: after wire emission, walk wires in Rust building
  entity/type path tables and adjacency (schema→items, subtype,
  interface imports with renames).
- Ext surface: `Set.graph` → magnus-backed query objects:
  `find_entity(path)`, `subtypes(path)`, `dependencies(schema)`,
  `closure(path)` — no hydration needed.
- Ruby side: `Indexes::ItemGraph` wraps it; path canonicalization is
  REQUIRED first (entity paths are file-qualified; some resolved
  base_paths are bare ids — see smrl-fullset memory).
- Parity gate: ItemGraph answers equal the Ruby-derived graph on SRL
  and SMRL.

## Depends on

refs overlay correctness (shipped, afb98be) — the graph consumes the
same resolved base_paths.
