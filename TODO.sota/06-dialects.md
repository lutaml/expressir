# 06 — Dialect awareness

EXPRESS the standard has editions; Expressir should speak them
explicitly.

## Parts (each ships)

1. Dialect flag: parser + checker accept `dialect: :"10303-11:1994" |
   :"10303-11:2004"` (default 2004). Gating: EXTENSIBLE/BASED_ON/
   GENERIC_ENTITY are 2004-only (1994 corpora exist in legacy
   resources); 1994 rejects them with a dialect note, 2004 accepts.
2. Amendment tracking: the Amd1 change list as a source document;
   edition-sensitive checker notes (`:check_dialect_*`).
3. Corpus pass: run both dialects over the resource slice; mixed
   dialects in one file produce a clear diagnostic.

## Acceptance

- A 1994-era resource schema parses clean under 1994, flags its
  non-1994 constructs under 2004-diagnostics mode.
