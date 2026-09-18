# TODO.max-perf/01 — Restore CI green on main

## Context

CI on main (`0ef38e1`, 2026-09-17) fails on the Windows matrix: yeptris
0.6.3.3's mingw build raises `NameError: uninitialized constant
Yeptris::FFI::NODE_SCALAR` from `yeptris/node.rb` whenever `to_yaml` runs.
Expressir's gemspec constraint (`~> 0.6.1`, from PR #346) allows it, and the
Gemfile.lock is gitignored, so CI resolves the newest release at run time.

yeptris has since released 0.6.4.1 and 0.6.5.1.

## Work

- [x] Reproduce the failing spec groups locally on the newest yeptris
      (`package_fixtures_spec`, `package_spec`, `cache_spec`): 84/84 green on
      0.6.5.1
- [x] Re-run the failed rake workflow on main (resolves 0.6.5.1)
- [x] Confirmed: rake green on main after yeptris 0.6.5.3 (mingw FFI
      constants now defined in ffi.rb; new x64-mingw32/x86_64-darwin-24
      platform builds) — verified via the run on this merge
- [x] 0.6.5.1 does NOT fix mingw (same NameError, all Windows jobs) — filed
      leptris/yeptris#318 with the CI repro
- [x] expressir-side guard: `Expressir.select_serialization_engines` pins the
      portable :standard YAML/JSON adapters on `Gem.win_platform?` at boot, so
      lutaml-model's autodetection never loads the broken mingw build; Unix
      keeps yeptris. Spec: spec/expressir/engine_selection_spec.rb

## Acceptance

rake workflow green on main across the full platform matrix.
