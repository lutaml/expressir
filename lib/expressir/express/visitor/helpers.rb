# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module Helpers
        private

        # Handle binary expression with left-associative operator chaining
        # @param operands [Array<Object>] The operands
        # @param operators [Array<Symbol>] The operators
        # @return [Model::Expressions::BinaryExpression] The combined binary expression
        def handle_binary_expression(operands, operators)
          if operands.length != operators.length + 1
            raise Error::VisitorInvalidStateError.new("handle_binary_expression called with invalid context")
          end

          expression = Model::Expressions::BinaryExpression.new(
            operator: operators[0],
            operand1: operands[0],
            operand2: operands[1],
          )
          operators[1..(operators.length - 1)].each_with_index do |operator, i|
            expression = Model::Expressions::BinaryExpression.new(
              operator: operator,
              operand1: expression,
              operand2: operands[i + 2],
            )
          end
          expression
        end

        # Handle binary supertype expression with left-associative operator chaining
        # @param operands [Array<Object>] The operands
        # @param operators [Array<Symbol>] The operators
        # @return [Model::SupertypeExpressions::BinarySupertypeExpression] The combined binary supertype expression
        def handle_binary_supertype_expression(operands, operators)
          if operands.length != operators.length + 1
            raise Error::VisitorInvalidStateError.new("handle_binary_supertype_expression called with invalid context")
          end

          expression = Model::SupertypeExpressions::BinarySupertypeExpression.new(
            operator: operators[0],
            operand1: operands[0],
            operand2: operands[1],
          )
          operators[1..(operators.length - 1)].each_with_index do |operator, i|
            expression = Model::SupertypeExpressions::BinarySupertypeExpression.new(
              operator: operator,
              operand1: expression,
              operand2: operands[i + 2],
            )
          end
          expression
        end
      end
    end
  end
end
