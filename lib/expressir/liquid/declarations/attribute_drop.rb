# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class AttributeDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def kind
          @model.kind
        end

        def supertype_attribute
          drop_klass_by_model(@model.supertype_attribute)
        end

        def optional
          @model.optional
        end

        def type
          drop_klass_by_model(@model.type)
        end

        def expression
          drop_klass_by_model(@model.expression)
        end
      end
    end
  end
end
