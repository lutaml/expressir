# frozen_string_literal: true

module Expressir
  module Liquid
    module Statements
      class RepeatDrop < ::Expressir::Liquid::StatementDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model)
          @model = model
          initialize_identifier(@model)
          super
        end

        def bound1
          drop_klass_by_model(@model.bound1)
        end

        def bound2
          drop_klass_by_model(@model.bound2)
        end

        def increment
          drop_klass_by_model(@model.increment)
        end

        def while_expression
          drop_klass_by_model(@model.while_expression)
        end

        def until_expression
          drop_klass_by_model(@model.until_expression)
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
