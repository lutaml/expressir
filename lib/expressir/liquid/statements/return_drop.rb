# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class ReturnDrop < ::Expressir::Liquid::StatementDrop
        def initialize(model)
          @model = model
          super
        end

        def expression
          drop_klass_by_model(@model.expression)
        end
      end
    end
  end
end
