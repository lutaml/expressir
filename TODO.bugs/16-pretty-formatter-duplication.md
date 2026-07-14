# 16 — PrettyFormatter duplicates declaration formatting from DeclarationsFormatter

**Priority:** P1 (DRY violation)

## Problem

`lib/expressir/express/pretty_formatter.rb:114-231` copies
`format_declarations_entity`, `format_declarations_function`,
`format_declarations_procedure`, `format_declarations_rule`,
`format_declarations_schema` nearly verbatim from
`lib/expressir/express/formatters/declarations_formatter.rb:112-232`.

PrettyFormatter introduces `format_scope_body` and `format_scope_footer`
helpers that the base formatter should also use.

## Fix

Refactor `DeclarationsFormatter` to use `format_scope_body` /
`format_scope_footer` helpers (parameterized by indent width).
PrettyFormatter then only overrides `indent` and `format_constant_block`.

## Acceptance

- PrettyFormatter no longer redefines `format_declarations_*` methods.
- Declaration formatting logic lives in one place.
- All formatter roundtrip specs pass.
