# frozen_string_literal: true

require_relative "helpers"

module Expressir
  module Express
    module Builders
      # Builds schema_body_declaration nodes - dispatches to declaration or rule.
      class SchemaBodyDeclBuilder
        def call(ast_data)
          if ast_data[:declaration]
            Builder.build({ declaration: ast_data[:declaration] })
          elsif ast_data[:rule_decl]
            Builder.build({ rule_decl: ast_data[:rule_decl] })
          end
        end
      end
    end
  end
end

Builder.register(:schema_body_declaration, Expressir::Express::Builders::SchemaBodyDeclBuilder.new)
