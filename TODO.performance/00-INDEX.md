# TODO.performance — the performance campaign

Shipped so far (see each file's Status for details):

- Rust core path + direct construction (`Serializable.instantiate`)
- Async batch compile (worker queue + ext BatchStream) — serial 288s → ~12s SRL cold
- EXSCS1 compiled-set artifact + warm start (byte-parity gated)
- Remarks overlay — warm skips the RemarkAttacher (`074b774`)
- Reference re-application overlay — warm skips the resolver (`afb98be`)
- parsanol 0.7.6 adopted (deadlock fix for worker threads; no perf regression)
- parsanol-rs#90 (VM gaps) and #100 (engine enhancements) filed upstream

Current numbers (SRL, 132 schemas / 8.1 MB):

| path | time |
|---|---|
| cold compile + artifact write | 11.3s |
| warm start (no parse/attacher/resolver) | 4.1s (hydration ≈ 2.5s of it) |
| full `metanorma compile` render | ~1m40s (PDF generation dominates) |

Task files:

- 01 — parsanol engine enhancements (upstream #100)
- 02 — skip to_parslet_compatible (12-14% of parse)
- 03 — serde→magnus fold (direct arena emission)
- 04 — rkyv/mmap artifact v2 (zero-copy)
- 05 — graph tables in the artifact + ItemGraph
- 06 — lazy per-schema hydration (Metanorma Tier 1)
- 07 — SMRL full-set artifact (1307 schemas / 43 MB)
- 08 — Metanorma collection e2e on the compiled set
- 09 — benchmark discipline and harnesses
