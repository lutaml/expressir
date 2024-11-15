# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class CaseDrop < ::Expressir::Liquid::StatementDrop
        def initialize(model)
          @model = model
          super
        end

        def expression
          drop_klass_by_model(@model.expression)
        end

        def actions
          return [] unless @model.actions

          @model.actions.map do |item|
            ::Expressir::Liquid::CaseActionDrop.new(item)
          end
        end

        def otherwise_statement
          ::Expressir::Liquid::StatementDrop.new(@model.otherwise_statement)
        end
      end
    end
  end
end
