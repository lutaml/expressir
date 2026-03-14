# frozen_string_literal: true

module Expressir
  module Express
    module Builders
      # Builds syntax (top-level) nodes into Repository objects.
      class SyntaxBuilder
        def call(ast_data)
          schemas = Builder.build_children(ast_data[:schema_decl])
          Expressir::Model::Repository.new(schemas: schemas.compact)
        end
      end
    end
  end
end
