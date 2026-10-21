# 04 — ARM↔MIM instance mapping verification

The Thurman end-game: verify that a MIM population is the image of an
ARM population through the module's mapping tables — RefPath applied
to instances, closing the loop between the schema-side mapping
validator (TODO.refpath-v2) and real data.

## Parts (each ships)

1. Mapping semantics over instances: for a module's mapping.yaml,
   given an ARM-typed population and the MIM population, follow each
   mapped reference path from each ARM instance through the MIM
   population and match the resolved target against the mapped
   attribute's expected value.
2. Instance-level RefPath: every path step resolves to actual
   instances (typing from TODO.instance/01); constraint values matched
   against actual attribute values; the `rules` lists checked as
   instance predicates; `alt_map` alternatives accepted when the
   primary path is unfollowable.
3. Report + triage: per-module verification receipts (ARM instance id,
   path, step, finding); drift classified as mapping drift vs
   population drift; feeds the WG12 corpus-drift policy program with
   instance-level evidence instead of schema-level inference.
4. Thurman interop: output comparable with the annotated-links
   validation of the PDES proposal (`pr463_validation_proposal.pdf`);
   AP 242 ed5 sample datasets as the acceptance corpus (DIS
   December 2026; AP 209/210/239/242 follow in 2027).

## Acceptance

- Synthetic ARM/MIM pair built from a shipped module: the image
  verifies clean; each seeded divergence (dropped instance, wrong
  target, violated constraint) produces exactly the intended finding.
- An AP 242 sample dataset verifies to completion; every finding
  carries path, step, and instance ids (triage-ready).
- No finding on any mapping the corpus proves valid — the standing
  no-new-errors oracle, now at instance level.
