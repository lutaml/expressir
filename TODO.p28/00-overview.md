# 00 — P28 program overview

ISO 10303-28:2007 XML representations of EXPRESS schemas and data.
Sources: `/Users/mulgogi/src/mn/iso-10303-detached-docs/sources/iso-10303-28/`
(edition 1 of the full standard, revising the 2003 TS; clause map:
5 document, 6 derived schemas, 7 default binding, 8 configured
binding, 9 XML document creation, 10 configuration language;
annex C base XML schema, D document schema, E valid populations,
G configuration examples).

Starting point: `Expressir::Express::Xsd` (#276) already renders a
v2-mapping XSD; the -28 clauses 7/9 semantics, the instance (uos)
half, and the document envelope do not exist.

## Ladder

| n | task | tier | status |
|---|------|------|--------|
| 01 | uos writer: population → clause 9 instance XML | data | todo |
| 02 | uos reader: clause 9 instance XML → population; value-identical round trip | data | todo |
| 03 | default XSD derivation upgraded to clause 7 (identifier rules §8.5.5, complex entities §7.x, INVERSE/DERIVED, interface imports) with the exp: common namespace | schema | in progress |
| 04 | iso_10303_28 envelope (clauses 5 + 9.2.1, annex D document schema): embedded/referenced express, header, multiple uos | document | todo |
| 05 | configured binding (clauses 8 + 10) | configuration | deferred — the configuration-directive layer over the default binding; its own program; the default binding is the conformance core |

## Standing rules

- Semantics cite clause ids (e.g. `:check_p28_*`, `# sec_9.3.1.1`).
- Instances ride the P21 record model (`Population`/`Record`/
  `ComplexRecord`, TODO.instance/03) so P21 and P28 compose and
  round-trips are value-identical.
- Reader/writer use moxml (the house XML stack); no hand-rolled
  serialization on model classes.
- The default binding (clause 7) is the target; configured behavior
  (clause 8/10 directives) is out of scope until 05.
