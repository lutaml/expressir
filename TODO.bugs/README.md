# TODO.bugs

Track all remaining architectural and code-cleanliness work identified by the
2026-07-14 audit. Each file describes one focused change.

## Priority legend
- **P0** — correctness bug or load-time failure
- **P1** — architectural friction with real leverage if fixed
- **P2** — cleanup; non-blocking but improves navigability
- **P3** — nice-to-have or speculative; defer unless time allows

## Index

| # | Priority | Title |
| --- | --- | --- |
| [01](01-stale-transformer-autoload.md) | P0 | Delete stale `Transformer` autoload and legacy `transformer/remark_handling.rb` |
| [02](02-parser-class-instance-vars.md) | P0 | Replace class-level `@exp_file`/`@repository` mutation in `Parser` with locals |
| [03](03-builder-mutable-state.md) | P1 | Thread `BuilderContext` through `Builder.build` instead of mutating `@source`/`@include_source` |
| [04](04-formatter-public-send-dispatch.md) | P1 | Replace `public_send(handler, node)` in `Formatter#format` with conventional override |
| [05](05-anonymous-formatter-subclass.md) | P1 | Cache the `Class.new(Formatter) { include HyperlinkFormatter }` in `ModelElement#source` as a constant |
| [06](06-collection-registry-single-source.md) | P1 | Consolidate `SCHEMA_DECL_COLLECTIONS` into `COLLECTION_REGISTRY` |
| [07](07-require-relative-cleanup.md) | P2 | Replace `require_relative` for `version` and `errors` in `lib/expressir.rb` with autoload |
| [08](08-require-expressir-in-commands.md) | P2 | Remove `require "expressir/changes"` from `commands/*.rb` (rely on autoload) |
| [09](09-parser-split.md) | P2 | Split `parser.rb` (1048 lines) into grammar + I/O service + schema-block scanner |
| [10](10-to-s-override.md) | P2 | Rename `ModelElement#to_s(no_remarks:, formatter:)` to `format` |
| [11](11-parser-class-variables.md) | P3 | Replace `@@cached_*` in `Parser` inner class with class instance variables |
| [12](12-marker-modules-vs-registry.md) | P3 | Generate `COLLECTION_REGISTRY` entries from marker-module declarations |
| [13](13-string-literal-scanner-limitation.md) | P1 | Add `:in_string` state to `RemarkScanner` (issue lutaml/expressir#313) |
