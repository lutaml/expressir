module Expressir
  module Express
    module Formatters
      module SupertypeExpressionsFormatter
        def self.included(base)
          base.register_formatter Model::SupertypeExpressions::BinarySupertypeExpression,
                                  :format_supertype_expressions_binary_supertype_expression
          base.register_formatter Model::SupertypeExpressions::OneofSupertypeExpression,
                                  :format_supertype_expressions_oneof_supertype_expression
        end

        def format_supertype_expressions_binary_supertype_expression(node)
          supertype_precedence = self.class.const_get(:SUPERTYPE_OPERATOR_PRECEDENCE)
          # The minimal-paren policy (expressir#651): left child needs
          # parens only when strictly looser; right child when
          # same-or-looser (left-associative operators).
          # An operand that carries the pairs of the source (`parenthesized`,
          # as for expressions, #707) writes them itself; the policy
          # applies to a model without that record.
          op1_higher_precedence = node.operand1.is_a?(Model::SupertypeExpressions::BinarySupertypeExpression) &&
            !node.operand1.parenthesized.to_i.positive? &&
            (supertype_precedence[node.operand1.operator] > supertype_precedence[node.operator])
          op2_higher_precedence = node.operand2.is_a?(Model::SupertypeExpressions::BinarySupertypeExpression) &&
            !node.operand2.parenthesized.to_i.positive? &&
            (supertype_precedence[node.operand2.operator] >= supertype_precedence[node.operator])

          [
            *if op1_higher_precedence
               "("
             end,
            format(node.operand1),
            *if op1_higher_precedence
               ")"
             end,
            " ",
            case node.operator
            when Model::SupertypeExpressions::BinarySupertypeExpression::AND then "AND"
            when Model::SupertypeExpressions::BinarySupertypeExpression::ANDOR then "ANDOR"
            end,
            " ",
            *if op2_higher_precedence
               "("
             end,
            format(node.operand2),
            *if op2_higher_precedence
               ")"
             end,
          ].join
        end

        def format_supertype_expressions_oneof_supertype_expression(node)
          [
            "ONEOF",
            "(",
            Array(node.operands).map { |x| format(x) }.join(", "),
            ")",
          ].join
        end
      end
    end
  end
end
