# 03 — P21 ladder completion + population management + receipts

The file format, its management, and the citable validation artifact.

## Parts (each ships)

1. Ladder completion: annex E named data sections (multiple DATA
   sections, per-section schema binding), annex I ANCHOR/REFERENCE
   (anchors as cross-file identity; REFERENCE parameter binding),
   annex J constants and extended literals — the currently
   loud-failing fixtures become positives; genuinely malformed input
   still fails loudly with the intended finding.
2. Dataset manifests: a population manifest YAML binding dataset files
   to a schema-library release (file list, schema edition, short-name
   maps, section inventory); `expressir population validate MANIFEST`
   runs the whole stack (01 + 02) over every file and writes the
   receipt. Mirror of the schema-side ELF manifest.
3. Population diff/patch: instance-level compare (added/removed/
   changed instances keyed by identity and value digest — the
   population sibling of SchemaCompare), patch application, and
   subset extraction by entity closure.
4. Round trips: P21→model→P21 with a byte-stable mode; P21↔JSON
   promoted from the test bridge to public API (JSON Schema exporter
   exists; the population serializer is published with it); P28
   (ISO 10303-28 XML) read/write per the -28 mapping.
5. Validation receipts: deterministic JSON/YAML report — dataset
   digest, library release, validator version, per-rule verdicts with
   instance ids, summary counts — reproducible byte-for-byte. The
   citable artifact binding dataset to schema release (validator
   version included).

## Acceptance

- Annex E/I/J fixtures: positives parse and validate clean; malformed
  negatives fail with exactly the intended finding.
- Manifest-driven validation of a sample dataset produces two
  byte-identical receipts on consecutive runs.
- Population diff: a known edit yields exactly the expected deltas;
  P21↔JSON↔P21 is value-identical; P28 round trip validated against
  the -28 examples in the detachment.
