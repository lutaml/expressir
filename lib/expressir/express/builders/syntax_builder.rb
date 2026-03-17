# frozen_string_literal: true

module Expressir
  module Express
    module Builders
      # Builds syntax (top-level) nodes into ExpFile objects.
      # Each parsed EXPRESS file is represented as an ExpFile containing schemas.
      class SyntaxBuilder
        # Build ExpFile from AST data
        # @param ast_data [Hash] The parsed AST with syntax node
        # @return [Model::ExpFile] ExpFile containing the parsed schemas
        def call(ast_data)
          schemas = Builder.build_children(ast_data[:schema_decl])
          Expressir::Model::ExpFile.new(schemas: schemas.compact)
        end
      end
    end
  end
end
