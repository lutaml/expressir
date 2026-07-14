# frozen_string_literal: true

module Expressir
  module Express
    autoload :Builder, "#{__dir__}/express/builder"
    autoload :BuilderContext, "#{__dir__}/express/builder_context"
    autoload :BuilderRegistry, "#{__dir__}/express/builder_registry"
    autoload :Builders, "#{__dir__}/express/builders"

    # Core classes (autoloaded for lazy loading)
    autoload :Cache, "#{__dir__}/express/cache"
    autoload :Error, "#{__dir__}/express/error"
    autoload :Formatter, "#{__dir__}/express/formatter"
    autoload :Formatters, "#{__dir__}/express/formatters"
    autoload :HyperlinkFormatter, "#{__dir__}/express/hyperlink_formatter"
    autoload :LineMap, "#{__dir__}/express/line_map"
    autoload :ModelVisitor, "#{__dir__}/express/model_visitor"
    autoload :NodePositionIndex, "#{__dir__}/express/node_position_index"
    autoload :Parser, "#{__dir__}/express/parser"
    autoload :PrettyFormatter, "#{__dir__}/express/pretty_formatter"
    autoload :RemarkAttacher, "#{__dir__}/express/remark_attacher"
    autoload :RemarkScanner, "#{__dir__}/express/remark_scanner"
    autoload :ResolveReferencesModelVisitor,
             "#{__dir__}/express/resolve_references_model_visitor"
    autoload :SchemaHeadFormatter, "#{__dir__}/express/schema_head_formatter"
    autoload :SchemaSourceFormatter, "#{__dir__}/express/schema_source_formatter"
    autoload :ScopeResolver, "#{__dir__}/express/scope_resolver"
    autoload :SourceFormatter, "#{__dir__}/express/source_formatter"
    autoload :StreamingBuilder, "#{__dir__}/express/streaming_builder"
  end
end
