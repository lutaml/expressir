# 05 — Interop exports: EXPRESS as a source

Expressir as the interchange point between EXPRESS and the rest of the
modeling world. These mappings are contributions (no ISO mapping
exists) — every decision is documented in the output module's docs.

## Parts (each ships)

1. JSON Schema export: entities → object schemas (attribute order,
   OPTIONAL → nullable, aggregates → arrays with bounds where
   expressible, SELECT → anyOf, ENUM → enum). Subtype handling: the
   closure flattened into allOf groups. Documented decisions file.
2. OWL/RDF export: the ifcOWL lineage generalized to arbitrary
   EXPRESS — entities → classes, supertype closure → subclass axes,
   attributes → properties with domain/range from the model, SELECT
   → union semantics, WHERE rules NOT exported (documented scope
   limit). Cite ifcOWL/EXPRESS→OWL literature in the decisions file.
3. Optional tier: UML/XMI export.

## Acceptance

- Export the SRL corpus; a consumer round-trip (validate exported
  JSON Schema against a Part 21-derived JSON serialization of the
  Annex H population).
