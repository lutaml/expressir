# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class CompoundDrop < ::Expressir::Liquid::StatementDrop
        def initialize(model)
          @model = model
          super
        end

        def statements
          return [] unless @model.statements

          @model.statements.map do |item|
            ::Expressir::Liquid::StatementDrop.new(item)
          end
        end
      end
    end
  end
end
