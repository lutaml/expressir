# TODO.bugs

Track all remaining architectural and code-cleanliness work identified by the
2026-07-14 audit. Each file describes one focused change.

## Priority legend
- **P0** — correctness bug or load-time failure
- **P1** — architectural friction with real leverage if fixed
- **P2** — cleanup; non-blocking but improves navigability
- **P3** — nice-to-have or speculative; defer unless time allows

## Status

All 13 TODOs are now **implemented**. Items 09 and 12 were the last two,
completed on 2026-07-15.

## Index

| # | Priority | Status | Title |
| --- | --- | --- | --- |
| [01](01-stale-transformer-autoload.md) | P0 | ✅ done | Delete stale `Transformer` autoload and legacy `transformer/remark_handling.rb` |
| [02](02-parser-class-instance-vars.md) | P0 | ✅ done | Replace class-level `@exp_file`/`@repository` mutation in `Parser` with locals |
| [03](03-builder-mutable-state.md) | P1 | ✅ done | Thread `BuilderContext` through `Builder.build` instead of mutating `@source`/`@include_source` |
| [04](04-formatter-public-send-dispatch.md) | P1 | ✅ done | Add registration-time guard on `Formatter.register_formatter` |
| [05](05-anonymous-formatter-subclass.md) | P1 | ✅ done | Cache the `Class.new(Formatter) { include HyperlinkFormatter }` as named classes |
| [06](06-collection-registry-single-source.md) | P1 | ✅ done | Consolidate `SCHEMA_DECL_COLLECTIONS` into `COLLECTION_REGISTRY` |
| [07](07-require-relative-cleanup.md) | P2 | ✅ done | Replace `require_relative` for `version` and `errors` with autoload |
| [08](08-require-expressir-in-commands.md) | P2 | ✅ done | Remove `require "expressir/changes"` from `commands/*.rb` |
| [09](09-parser-split.md) | P2 | ✅ done | Split `parser.rb` into grammar + schema-block scanner + facade |
| [10](10-to-s-override.md) | P2 | ✅ done | Rename `ModelElement#to_s(no_remarks:, formatter:)` to `format` |
| [11](11-parser-class-variables.md) | P3 | ✅ done | Replace `@@cached_*` in `Parser` with class instance variables |
| [12](12-marker-modules-vs-registry.md) | P3 | ✅ done | Generate `COLLECTION_REGISTRY` from `collection_attributes` macro on model classes |
| [13](13-string-literal-scanner-limitation.md) | P1 | ✅ done | Add `:in_string` state to `RemarkScanner` (issue lutaml/expressir#313) |
