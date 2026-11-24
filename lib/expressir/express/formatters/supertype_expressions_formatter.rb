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
            supertype_operand_list(Array(node.operands)),
            ")",
          ].join
        end

        # The operands of a ONEOF, on one line; one a line when a remark
        # stands at one of them. A remark that follows an operand on its
        # line is written after the comma; the remark of the last operand
        # of the whole expression is written after the `;`
        # ({#last_supertype_operand_remarks}), as before the `)` a tail
        # remark would take the `)` and the `;` with it.
        def supertype_operand_list(operands)
          unless operands.any? { |x| supertype_operand_remarks?(x) }
            return operands.map { |x| format(x) }.join(", ")
          end

          item_indent = " " * 6 # the width of `ONEOF(`
          last = operands.length - 1
          operands.each_with_index.map do |operand, i|
            text = supertype_operand_text(operand, item_indent)
            i == last ? text : "#{text},#{supertype_operand_inline_remarks(operand)}"
          end.join("\n#{item_indent}")
        end

        # An operand with the remarks that stand on lines of their own above
        # it, each at the depth of the operands.
        def supertype_operand_text(operand, item_indent)
          leading = format_leading_statement_remarks(operand)
          return format(operand) if leading.empty?

          own = format(operand).delete_prefix("#{leading.join("\n")}\n")
          [*leading, own].join("\n#{item_indent}")
        end

        def supertype_operand_remarks?(operand)
          operand.is_a?(Model::References::SimpleReference) &&
            (!format_leading_statement_remarks(operand).empty? ||
              !supertype_operand_inline_remarks(operand).empty?)
        end

        # The remarks that follow an operand on its line. An operand is a
        # reference, which is no TakesInlineRemark, so they are read here.
        def supertype_operand_inline_remarks(operand)
          return "" unless operand.is_a?(Model::References::SimpleReference)
          return "" if @no_remarks && !@keep_untagged_remarks

          Array(operand.untagged_remarks).filter_map do |remark|
            next unless remark.inline? && remark.region.nil?

            formatted = format_untagged_remark(remark)
            " #{formatted}" unless formatted.empty?
          end.join
        end

        # The remark that follows the last operand of the whole expression.
        def last_supertype_operand_remarks(expression)
          case expression
          when Model::SupertypeExpressions::OneofSupertypeExpression
            last_supertype_operand_remarks(Array(expression.operands).last)
          when Model::SupertypeExpressions::BinarySupertypeExpression
            last_supertype_operand_remarks(expression.operand2)
          else supertype_operand_inline_remarks(expression)
          end
        end
      end
    end
  end
end
