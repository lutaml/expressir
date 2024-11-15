# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class AliasDrop < ::Expressir::Liquid::StatementDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
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
      end
    end
  end
end
