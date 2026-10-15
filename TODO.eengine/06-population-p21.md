# 06 — Population / Part 21

TODO.parity-ee 13, scope ladder (each step ships):

1. P21 reader: parsanol grammar for ISO 10303-21 (HEADER entities,
   DATA section: complex instances `(A(...)B(...))`, simple
   `#1=TYPE(...)`, list/set/typed-ref values, enums `.T.`, binary
   `"...`, redefines `/`); a `Model::Population` (header + instances).
2. Population validation against a loaded schema: instance entity
   exists (direct or complex against the supertype graph), attribute
   names/arity match, value types check.
3. eengine differential on the Part 21 fixtures
   (`~/src/mn/iso-10303-detached-docs/sources/iso-10303-21*`).
