# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class IfDrop < ::Expressir::Liquid::StatementDrop
        def initialize(model)
          @model = model
          super
        end

        def expression
          drop_klass_by_model(@model.expression)
        end

        def statements
          return [] unless @model.statements

          @model.statements.map do |item|
            ::Expressir::Liquid::StatementDrop.new(item)
          end
        end

        def else_statements
          return [] unless @model.else_statements

          @model.else_statements.map do |item|
            ::Expressir::Liquid::StatementDrop.new(item)
          end
        end
      end
    end
  end
end
