# 06 — Memory/perf re-measure with binding-by-default

## Goal
The recorded profile ("50x memory ratio not achieved", pure-Ruby parse
dominating) predates binding-by-default. Consumers now get the Rust
parse path automatically; re-measure and refresh the story.

## Steps
- rerun the memory harness (TODO.memory methodology) with
  NATIVE_AVAILABLE true on the same fixtures
- record ratio vs the 50x target; note remaining hot spots
- update TODO.memory notes + the perf memory file

## Acceptance
- fresh numbers committed alongside the old ones, with the parse
  backend identified per measurement
