# frozen_string_literal: true

require_relative "helpers"

module Expressir
  module Express
    module Builders
      # Builds built-in constant, function, and procedure reference nodes.
      class BuiltInBuilder
        include Helpers

        def build_built_in_constant(ast_data)
          id = extract_nested_text(ast_data)
          Expressir::Model::References::SimpleReference.new(id: id)
        end

        def build_built_in_function(ast_data)
          id = extract_text(ast_data[:str])
          Expressir::Model::References::SimpleReference.new(id: id)
        end

        def build_built_in_procedure(ast_data)
          id = extract_text(ast_data[:str])
          Expressir::Model::References::SimpleReference.new(id: id)
        end

        def build_general_ref(ast_data)
          if ast_data[:constant_ref]
            Builder.build({ constant_ref: ast_data[:constant_ref] })
          elsif ast_data[:function_ref]
            Builder.build({ function_ref: ast_data[:function_ref] })
          elsif ast_data[:parameter_ref]
            Builder.build({ parameter_ref: ast_data[:parameter_ref] })
          elsif ast_data[:variable_ref]
            Builder.build({ variable_ref: ast_data[:variable_ref] })
          elsif ast_data[:entity_ref]
            Builder.build({ entity_ref: ast_data[:entity_ref] })
          elsif ast_data[:type_ref]
            Builder.build({ type_ref: ast_data[:type_ref] })
          elsif ast_data[:attribute_ref]
            Builder.build({ attribute_ref: ast_data[:attribute_ref] })
          elsif ast_data[:enumeration_ref]
            Builder.build({ enumeration_ref: ast_data[:enumeration_ref] })
          end
        end

        def build_named_types(ast_data)
          if ast_data[:entity_ref]
            Builder.build({ entity_ref: ast_data[:entity_ref] })
          elsif ast_data[:type_ref]
            Builder.build({ type_ref: ast_data[:type_ref] })
          end
        end

        def build_item(ast_data)
          if ast_data[:entity_ref]
            Builder.build({ entity_ref: ast_data[:entity_ref] })
          elsif ast_data[:type_ref]
            Builder.build({ type_ref: ast_data[:type_ref] })
          end
        end

        def build_procedure_ref(ast_data)
          id = extract_id_ref(ast_data)
          Expressir::Model::References::SimpleReference.new(id: id)
        end

        def build_schema_ref(ast_data)
          id = extract_id_ref(ast_data)
          Expressir::Model::References::SimpleReference.new(id: id)
        end
      end
    end
  end
end

builder = Expressir::Express::Builders::BuiltInBuilder.new

Builder.register(:built_in_constant) { |d| builder.build_built_in_constant(d) }
Builder.register(:built_in_function) { |d| builder.build_built_in_function(d) }
Builder.register(:built_in_procedure) do |d|
  builder.build_built_in_procedure(d)
end
Builder.register(:general_ref) { |d| builder.build_general_ref(d) }
Builder.register(:named_types) { |d| builder.build_named_types(d) }
Builder.register(:item) { |d| builder.build_item(d) }
Builder.register(:procedure_ref) { |d| builder.build_procedure_ref(d) }
Builder.register(:schema_ref) { |d| builder.build_schema_ref(d) }
