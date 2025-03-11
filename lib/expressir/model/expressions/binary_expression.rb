module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.1 Arithmetic operators
      # - section 12.2 Relational operators
      # - section 12.3 Binary operators
      # - section 12.4 Logical operators
      # - section 12.5 String operators
      # - section 12.6 Aggregate operators
      # - section 12.10 Complex entity instance construction operator
      class BinaryExpression < ModelElement
        ADDITION = "ADDITION"
        AND = "AND"
        COMBINE = "COMBINE"
        EQUAL = "EQUAL"
        EXPONENTIATION = "EXPONENTIATION"
        GREATER_THAN = "GREATER_THAN"
        GREATER_THAN_OR_EQUAL = "GREATER_THAN_OR_EQUAL"
        IN = "IN"
        INSTANCE_EQUAL = "INSTANCE_EQUAL"
        INSTANCE_NOT_EQUAL = "INSTANCE_NOT_EQUAL"
        INTEGER_DIVISION = "INTEGER_DIVISION"
        LESS_THAN = "LESS_THAN"
        LESS_THAN_OR_EQUAL = "LESS_THAN_OR_EQUAL"
        LIKE = "LIKE"
        MODULO = "MODULO"
        MULTIPLICATION = "MULTIPLICATION"
        NOT_EQUAL = "NOT_EQUAL"
        OR = "OR"
        REAL_DIVISION = "REAL_DIVISION"
        SUBTRACTION = "SUBTRACTION"
        XOR = "XOR"

        attribute :operator, :string,
                  values: %w[
                            ADDITION AND COMBINE EQUAL EXPONENTIATION
                            GREATER_THAN
                            GREATER_THAN_OR_EQUAL IN INSTANCE_EQUAL
                            INSTANCE_NOT_EQUAL
                            INTEGER_DIVISION LESS_THAN LESS_THAN_OR_EQUAL LIKE
                            MODULO MULTIPLICATION NOT_EQUAL OR REAL_DIVISION
                            SUBTRACTION XOR
                          ]
        attribute :operand1, ModelElement
        attribute :operand2, ModelElement
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "operator", to: :operator
          map "operand1", to: :operand1
          map "operand2", to: :operand2
        end
      end
    end
  end
end
