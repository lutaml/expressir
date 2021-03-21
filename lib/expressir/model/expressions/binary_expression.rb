module Expressir
  module Model
    module Expressions
      class BinaryExpression < ModelElement
        ADDITION = :ADDITION
        AND = :AND
        ANDOR = :ANDOR
        COMBINE = :COMBINE
        EQUAL = :EQUAL
        EXPONENTIATION = :EXPONENTIATION
        GREATER_THAN = :GREATER_THAN
        GREATER_THAN_OR_EQUAL = :GREATER_THAN_OR_EQUAL
        IN = :IN
        INSTANCE_EQUAL = :INSTANCE_EQUAL
        INSTANCE_NOT_EQUAL = :INSTANCE_NOT_EQUAL
        INTEGER_DIVISION = :INTEGER_DIVISION
        LESS_THAN = :LESS_THAN
        LESS_THAN_OR_EQUAL = :LESS_THAN_OR_EQUAL
        LIKE = :LIKE
        MODULO = :MODULO
        MULTIPLICATION = :MULTIPLICATION
        NOT_EQUAL = :NOT_EQUAL
        OR = :OR
        REAL_DIVISION = :REAL_DIVISION
        SUBTRACTION = :SUBTRACTION
        XOR = :XOR

        model_attr_accessor :operator
        model_attr_accessor :operand1
        model_attr_accessor :operand2

        def initialize(options = {})
          @operator = options[:operator]
          @operand1 = options[:operand1]
          @operand2 = options[:operand2]

          super
        end
      end
    end
  end
end