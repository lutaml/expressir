# 14 — Model layer embeds EXPRESS formatting logic

**Priority:** P1 (leaky seam)

## Problem

`ModelElement#source`, `Schema#source`, `Schema#formatted`, `Schema#full_source`
all embed formatting logic in the model layer, creating a hard dependency
from model → express.

- `lib/expressir/model/model_element.rb:130-132` — `source` calls
  `Expressir::Express::SourceFormatter.format(self)`.
- `lib/expressir/model/declarations/schema.rb:88-98` — `source`, `formatted`,
  `full_source` call `Expressir::Express::SchemaSourceFormatter`,
  `Expressir::Express::Formatter`, etc.

## Fix

Move these methods to the express layer as class methods on the
formatters. Callers switch from `schema.source` to
`Expressir::Express::SchemaSourceFormatter.format(schema)`.

Keep thin delegators on the model for backward compatibility with a
deprecation note.

## Acceptance

- Model classes have no reference to `Expressir::Express::*Formatter`.
- Callers in lib/ updated to use the express-layer methods.
- All specs pass.
