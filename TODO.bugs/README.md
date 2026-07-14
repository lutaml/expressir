# TODO.bugs

Track all remaining architectural and code-cleanliness work identified by the
2026-07-14 audit. Each file describes one focused change.

## Priority legend
- **P0** — correctness bug or load-time failure
- **P1** — architectural friction with real leverage if fixed
- **P2** — cleanup; non-blocking but improves navigability
- **P3** — nice-to-have or speculative; defer unless time allows

## Status

All 13 original TODOs (01-13) are **implemented**.
TODOs 14-25 from the second audit: 14-23 documented, 18-20+22+23+25 implemented,
14-17+21+24 deferred.

## Index

| # | Priority | Status | Title |
| --- | --- | --- | --- |
| [01](01-stale-transformer-autoload.md) | P0 | done | Delete stale `Transformer` autoload and legacy `transformer/remark_handling.rb` |
| [02](02-parser-class-instance-vars.md) | P0 | done | Replace class-level `@exp_file`/`@repository` mutation in `Parser` with locals |
| [03](03-builder-mutable-state.md) | P1 | done | Thread `BuilderContext` through `Builder.build` instead of mutating `@source`/`@include_source` |
| [04](04-formatter-public-send-dispatch.md) | P1 | done | Add registration-time guard on `Formatter.register_formatter` |
| [05](05-anonymous-formatter-subclass.md) | P1 | done | Cache `Class.new(Formatter)` as named classes |
| [06](06-collection-registry-single-source.md) | P1 | done | Consolidate `SCHEMA_DECL_COLLECTIONS` into `COLLECTION_REGISTRY` |
| [07](07-require-relative-cleanup.md) | P2 | done | Replace `require_relative` for `version` and `errors` with autoload |
| [08](08-require-expressir-in-commands.md) | P2 | done | Remove `require "expressir/changes"` from `commands/*.rb` |
| [09](09-parser-split.md) | P2 | done | Split `parser.rb` into grammar + schema-block scanner + facade |
| [10](10-to-s-override.md) | P2 | done | Rename `ModelElement#to_s(no_remarks:, formatter:)` to `format` |
| [11](11-parser-class-variables.md) | P3 | done | Replace `@@cached_*` in `Parser` with class instance variables |
| [12](12-marker-modules-vs-registry.md) | P3 | done | Generate `COLLECTION_REGISTRY` from `collection_attributes` macro |
| [13](13-string-literal-scanner-limitation.md) | P1 | done | Add `:in_string` state to `RemarkScanner` (issue #313) |
| [14](14-model-formatting-leak.md) | P1 | deferred | Model layer embeds EXPRESS formatting logic |
| [15](15-expression-children-macro.md) | P1 | deferred | EXPRESSION_CHILDREN hash should be a model macro |
| [16](16-pretty-formatter-duplication.md) | P1 | deferred | PrettyFormatter duplicates declaration formatting |
| [17](17-snake-case-cache-mutable-constant.md) | P1 | deferred | SNAKE_CASE_CACHE is a mutable module constant |
| [18](18-const-get-private-constants.md) | P2 | done | Remove `private_constant` on format constants |
| [19](19-format-methods-public.md) | P2 | done | Change `public_send` → `send` so format methods can be private |
| [20](20-coverage-nested-entities-dedup.md) | P2 | done | Coverage.find_nested_entities uses collection_attributes_list |
| [21](21-operator-tokens-secondary-dispatch.md) | P2 | deferred | OPERATOR_TOKENS secondary dispatch mechanism |
| [22](22-builder-fast-path-wrappers.md) | P2 | done | Remove 6 trivial fast-path wrapper methods from Builder |
| [23](23-coverage-inverse-maps.md) | P2 | done | Derive Coverage inverse maps from single TYPE_PAIRS source |
| [24](24-streaming-builder-complexity.md) | P3 | deferred | Split StreamingBuilder convert_ast_format (190 lines) |
| [25](25-debug-puts-in-production.md) | P3 | done | Remove debug puts statements from StreamingBuilder |
