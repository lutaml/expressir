# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class ProcedureCallDrop < ::Expressir::Liquid::StatementDrop
        def initialize(model)
          @model = model
          super
        end

        def procedure
          drop_klass_by_model(@model.procedure)
        end

        def parameters
          return [] unless @model.parameters

          @model.parameters.map do |item|
            drop_klass_by_model(item)
          end
        end
      end
    end
  end
end
