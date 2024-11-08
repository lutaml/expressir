# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class WhereRuleDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def expression
          drop_klass_by_model(@model.expression)
        end
      end
    end
  end
end
