# 07 — Part 28 XML: select mapping v2 (#276)

## Goal
Full ISO 10303-28 EXPRESS-to-XML beyond the v1 skeleton
(lib/expressir/express/xsd.rb): proper SELECT mapping (currently
xs:anyType), aggregate/optional fidelity, schema-level structure.

## Steps
- ISO 10303-28 mapping rules for SELECT types (union/member semantics)
- apply on top of xsd.rb's element/complexType generation
- validate generated XSDs against the ISO 10303-28 conformance examples

## Acceptance
- a select-typed attribute renders per the standard (not xs:anyType)
- the v1 examples still generate unchanged except where v2 improves them
