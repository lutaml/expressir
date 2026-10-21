# 01 — Instance typing + value/type conformance

Everything downstream (rule scoping, SELECT checking, ARM-view
queries) needs the answer to one question about every instance: which
entities does it conform to?

## Parts (each ships)

1. Typing engine: for every instance in a population, the set of
   entities it conforms to, through the subtype graph. Simple records
   (one keyword + supertype closure), complex records (multi-entity
   AND instantiation validated against the supertype constraints:
   ANDOR admissible, ONEOF exclusive, total-over respected),
   short-name resolution via the clause-12.3 map. Cached per
   population; public API `Expressir::P21::Typing#of(instance)`.
2. Slot value/type conformance: the clause-12 slot mapping (already
   in `P21::Validator`) extended with value-domain checking —
   primitive domains (INTEGER, REAL precision, NUMBER, STRING, BINARY
   width, BOOLEAN, LOGICAL), defined types unfolded to their base
   with the defined type's WHERE rules evaluated (ch.8 domain rules;
   the evaluator supplies evaluation), aggregates (LIST/ARRAY/SET/BAG
   bounds, SET uniqueness, element types, nested aggregates, ARRAY
   OPTIONAL elements), enumeration membership, and instance references
   checked against the target instance's typing from part 1.
3. SELECT membership: an attribute typed by a SELECT requires the
   referenced instance's typing to hit one of the SELECT's arms,
   through BASED_ON inheritance chains; findings name the arm tried.

## Acceptance

- One firing and one clean spec example per rule, citing the clause.
- Annex H population: every instance's typing computed; every slot
  value-conformant (zero findings).
- Mutation sweep: corrupting one value (wrong enum item, bound
  overflow, wrong reference type, bad complex combination) produces
  exactly the intended finding and no other.
- A complex-record population exercises ANDOR/ONEOF admissibility.
