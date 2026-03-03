# frozen_string_literal: true

require_relative "helpers"

module Expressir
  module Express
    module Builders
      # Builds reference nodes (attribute_ref, entity_ref, etc.).
      # Returns SimpleReference for all reference types.
      class ReferenceBuilder
        include Helpers

        def call(ast_data)
          id = extract_id_ref(ast_data)
          Expressir::Model::References::SimpleReference.new(id: id)
        end
      end
    end
  end
end

# Register for all reference types
%i[attribute_ref constant_ref entity_ref enumeration_ref function_ref
   parameter_ref procedure_ref rule_ref rule_label_ref schema_ref
   subtype_constraint_ref type_label_ref type_ref variable_ref].each do |ref_type|
  Builder.register(ref_type, Expressir::Express::Builders::ReferenceBuilder.new)
end
