module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.1 Arithmetic operators
      # - section 12.4.1 NOT operator
      class UnaryExpression < Expression
        MINUS = "MINUS"
        NOT = "NOT"
        PLUS = "PLUS"

        attribute :operator, :string, values: %w[MINUS NOT PLUS]
        attribute :operand, Expression
      end
    end
  end
end
