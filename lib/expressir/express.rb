# frozen_string_literal: true

module Expressir
  module Express
    autoload :Builder, "#{__dir__}/express/builder"
    autoload :Builders, "#{__dir__}/express/builders"
    # autoload :BuilderRegistry, "#{__dir__}/express/builder_registry"

    # Core classes (autoloaded for lazy loading)
    autoload :Cache, "#{__dir__}/express/cache"
    autoload :Error, "#{__dir__}/express/error"
    autoload :Formatter, "#{__dir__}/express/formatter"
    autoload :Formatters, "#{__dir__}/express/formatters"
    autoload :HyperlinkFormatter, "#{__dir__}/express/hyperlink_formatter"
    autoload :ModelVisitor, "#{__dir__}/express/model_visitor"
    autoload :Parser, "#{__dir__}/express/parser"
    autoload :PrettyFormatter, "#{__dir__}/express/pretty_formatter"
    autoload :RemarkAttacher, "#{__dir__}/express/remark_attacher"
    autoload :ResolveReferencesModelVisitor,
             "#{__dir__}/express/resolve_references_model_visitor"
    autoload :SchemaHeadFormatter, "#{__dir__}/express/schema_head_formatter"
    autoload :StreamingBuilder, "#{__dir__}/express/streaming_builder"

    autoload :Transformer, "#{__dir__}/express/transformer"
  end
end

# Eagerly load builders (they register themselves at load time)
require_relative "express/builder_registry"
