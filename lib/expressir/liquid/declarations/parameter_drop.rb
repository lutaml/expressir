# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class ParameterDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def var
          @model.var
        end

        def type
          drop_klass_by_model(@model.type)
        end
      end
    end
  end
end
