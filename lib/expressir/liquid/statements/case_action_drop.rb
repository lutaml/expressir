# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class CaseActionDrop < ::Expressir::Liquid::StatementDrop
        def initialize(model)
          @model = model
          super
        end

        def labels
          return [] unless @model.labels

          @model.labels.map do |item|
            drop_klass_by_model(item)
          end
        end

        def statement
          ::Expressir::Liquid::StatementDrop.new(@model.statement)
        end
      end
    end
  end
end
