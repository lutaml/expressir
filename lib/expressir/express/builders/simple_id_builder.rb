# frozen_string_literal: true

require_relative "helpers"

module Expressir
  module Express
    module Builders
      # Builds simple ID nodes (simple_id, schema_id, entity_id, etc.)
      # These return a string, not a Model object.
      class SimpleIdBuilder
        include Helpers

        def call(ast_data)
          extract_text(ast_data[:str]) || extract_text(ast_data[:simple_id]&.dig(:str))
        end
      end
    end
  end
end

# Register for all ID types
%i[simple_id schema_id entity_id type_id function_id procedure_id
   rule_id rule_label_id constant_id parameter_id variable_id
   enumeration_id subtype_constraint_id type_label_id attribute_id].each do |id_type|
  Builder.register(id_type, Expressir::Express::Builders::SimpleIdBuilder.new)
end
