# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class SubtypeConstraintDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def applies_to
          drop_klass_by_model(@model.applies_to)
        end

        def abstract
          @model.abstract
        end

        def total_over
          return [] unless @model.total_over

          @model.total_over.map do |item|
            drop_klass_by_model(item)
          end
        end

        def supertype_expression
          drop_klass_by_model(@model.supertype_expression)
        end
      end
    end
  end
end
