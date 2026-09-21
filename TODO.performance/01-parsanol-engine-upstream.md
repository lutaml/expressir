**Status: FILED UPSTREAM — parsanol-rs#100 (+#90); blocked on upstream**

## Why

The packrat parse is linear but interpreter-constant-bound (~230-340
KB/s on EXPRESS); it dominates cold compile. The bytecode VM is 2-3x
on mid-size schemas but 0.54x with 8x arena memory on the two most
ambiguous long-forms (2.2-2.5 MB mim_lf) — no memoization.

## Asks (filed in #100)

1. Selective memoization in the VM (memoize only re-entrant atoms) —
   combines VM constants with packrat guarantees; we adopt in batch
   workers immediately.
2. Per-atom profiling counters (dispatch count/time, release-usable).
3. Whether `parser/simd.rs` is wired into PortableParser terminals.
4. A stable raw-tree API (unblocks TODO.performance/02).
5. Backtracking-hotspot warnings in grammar_analysis.

## When it lands

- Re-run `expressir-rs/examples/{vm_bench,corpus_bench,normalize_bench}`
  over the 29-file corpus AND the two worst mim_lf files.
- Adopt per-file backend selection if long-forms still regress
  (VM for small/mid, packrat for the giants) — selection by measured
  crossover size, not grammar analysis alone.
- Expected effect: cold compile parse share ~2-3x faster.

## Evidence

vm_bench (0.7.6): mid-size schemas 2-3x on VM; ap210 mim_lf packrat
10.8s vs VM 20.2s + 2.1 GB arena. A/B 0.7.3 vs 0.7.6: no regression
(best-of 3.53s vs 3.57s).
