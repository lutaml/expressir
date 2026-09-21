**Status: STANDING PRACTICE — apply to every perf change**

## Rules learned the hard way

- The shared box's load ranges 5-300+. Wall-clock comparisons across
  sessions are meaningless. Use interleaved A/B within one session,
  best-of-N per variant (N≥3), and report load alongside.
- Fork-isolated CPU-time (Process.times) for Ruby end-to-end; wall
  only for Rust-only benches under low load.
- `gem list --remote` hides prereleases — pass `--prerelease`.
- Rebuilds: `make RB_SYS_CARGO_PROFILE=release` in ext; verify the
  LOCAL-ITERATION [patch] is present first (silent stale-main builds
  have burned us twice).
- One-off conclusions need a control: the "0.7.6 is 8x slower"
  scare was pure load noise; the controlled A/B showed parity.

## Harnesses

- expressir-rs: examples/{corpus_bench,vm_bench,normalize_bench}.rb —
  argv file lists; corpus list at /tmp/corpus_files.txt (regenerate
  from schema_docs manifests after reboots).
- expressir: /tmp/srl_bench2-style scripts (cold+write vs warm with
  byte-parity check) — promote one into `rake benchmark` when stable.
