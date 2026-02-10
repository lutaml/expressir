# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module Expressions
        private

        # Visit actual parameter list
        # @param ctx [Ctx] The context containing the parameter list
        # @return [Array<Object>] The visited parameters
        def visit_actual_parameter_list(ctx)
          ctx__parameter = ctx.parameter

          visit_if_map(ctx__parameter)
        end

        # Visit addition-like operator (+, -, OR, XOR)
        # @param ctx [Ctx] The context containing the operator
        # @return [Symbol] The operator constant
        def visit_add_like_op(ctx)
          ctx__text = ctx.values[0].text
          ctx__ADDITION = ctx__text == "+"
          ctx__SUBTRACTION = ctx__text == "-"
          ctx__OR = ctx.tOR
          ctx__XOR = ctx.tXOR

          if ctx__ADDITION
            Model::Expressions::BinaryExpression::ADDITION
          elsif ctx__SUBTRACTION
            Model::Expressions::BinaryExpression::SUBTRACTION
          elsif ctx__OR
            Model::Expressions::BinaryExpression::OR
          elsif ctx__XOR
            Model::Expressions::BinaryExpression::XOR
          else
            raise Error::VisitorInvalidStateError.new("visit_add_like_op called with invalid context")
          end
        end

        # Visit entity constructor (function call)
        # @param ctx [Ctx] The context containing the entity constructor
        # @return [Model::Expressions::FunctionCall] The function call
        def visit_entity_constructor(ctx)
          ctx__entity_ref = ctx.entity_ref
          ctx__expression = ctx.expression

          entity = visit_if(ctx__entity_ref)
          parameters = visit_if_map(ctx__expression)

          # Model::Expressions::EntityConstructor.new(
          #   entity: entity,
          #   parameters: parameters
          # )
          Model::Expressions::FunctionCall.new(
            function: entity,
            parameters: parameters,
          )
        end

        # Visit expression (with optional relational operator)
        # @param ctx [Ctx] The context containing the expression
        # @return [Object] The visited expression
        def visit_expression(ctx)
          ctx__simple_expression = ctx.simple_expression
          ctx__rel_op_extended = ctx.rel_op_extended
          ctx__rhs = ctx.rhs

          if ctx__rhs
            operator = visit_if(ctx__rel_op_extended)
            operand1 = visit_if(ctx__simple_expression)
            operand2 = visit_if(ctx__rhs.values[0])

            Model::Expressions::BinaryExpression.new(
              operator: operator,
              operand1: operand1,
              operand2: operand2,
            )
          else
            visit_if(ctx__simple_expression)
          end
        end

        # Visit factor (with optional exponentiation)
        # @param ctx [Ctx] The context containing the factor
        # @return [Object] The visited factor
        def visit_factor(ctx)
          ctx__simple_factor = ctx.simple_factor
          ctx__rhs = ctx.rhs

          if ctx__rhs
            operator = Model::Expressions::BinaryExpression::EXPONENTIATION
            operand1 = visit(ctx__simple_factor)
            operand2 = visit(ctx__rhs.simple_factor)

            Model::Expressions::BinaryExpression.new(
              operator: operator,
              operand1: operand1,
              operand2: operand2,
            )
          else
            visit_if(ctx__simple_factor)
          end
        end

        # Visit function call
        # @param ctx [Ctx] The context containing the function call
        # @return [Model::Expressions::FunctionCall] The function call
        def visit_function_call(ctx)
          ctx__built_in_function = ctx.built_in_function
          ctx__function_ref = ctx.function_ref
          ctx__actual_parameter_list = ctx.actual_parameter_list

          function = visit_if(ctx__built_in_function || ctx__function_ref)
          parameters = visit_if(ctx__actual_parameter_list, nil)

          Model::Expressions::FunctionCall.new(
            function: function,
            parameters: parameters,
          )
        end

        # Visit general reference (parameter or variable)
        # @param ctx [Ctx] The context containing the reference
        # @return [Object] The visited reference
        def visit_general_ref(ctx)
          ctx__parameter_ref = ctx.parameter_ref
          ctx__variable_id = ctx.variable_id

          visit_if(ctx__parameter_ref || ctx__variable_id)
        end

        # Visit interval expression
        # @param ctx [Ctx] The context containing the interval
        # @return [Model::Expressions::Interval] The interval expression
        def visit_interval(ctx)
          ctx__interval_low = ctx.interval_low
          ctx__interval_op = ctx.interval_op
          ctx__interval_op2 = ctx.interval_op2.interval_op
          ctx__interval_item = ctx.interval_item
          ctx__interval_high = ctx.interval_high

          low = visit_if(ctx__interval_low)
          operator1 = visit_if(ctx__interval_op)
          item = visit_if(ctx__interval_item)
          operator2 = visit_if(ctx__interval_op2)
          high = visit_if(ctx__interval_high)

          Model::Expressions::Interval.new(
            low: low,
            operator1: operator1,
            item: item,
            operator2: operator2,
            high: high,
          )
        end

        # Visit interval high bound
        # @param ctx [Ctx] The context containing the high bound
        # @return [Object] The visited high bound
        def visit_interval_high(ctx)
          ctx__simple_expression = ctx.simple_expression

          visit_if(ctx__simple_expression)
        end

        # Visit interval item
        # @param ctx [Ctx] The context containing the interval item
        # @return [Object] The visited interval item
        def visit_interval_item(ctx)
          ctx__simple_expression = ctx.simple_expression

          visit_if(ctx__simple_expression)
        end

        # Visit interval low bound
        # @param ctx [Ctx] The context containing the low bound
        # @return [Object] The visited low bound
        def visit_interval_low(ctx)
          ctx__simple_expression = ctx.simple_expression

          visit_if(ctx__simple_expression)
        end

        # Visit interval operator (< or <=)
        # @param ctx [Ctx] The context containing the operator
        # @return [Symbol] The operator constant
        def visit_interval_op(ctx)
          ctx__text = ctx.values[0].text
          ctx__LESS_THAN = ctx__text == "<"
          ctx__LESS_THAN_OR_EQUAL = ctx__text == "<="

          if ctx__LESS_THAN
            Model::Expressions::Interval::LESS_THAN
          elsif ctx__LESS_THAN_OR_EQUAL
            Model::Expressions::Interval::LESS_THAN_OR_EQUAL
          else
            raise Error::VisitorInvalidStateError.new("visit_interval_op called with invalid context")
          end
        end

        # Visit logical expression
        # @param ctx [Ctx] The context containing the logical expression
        # @return [Object] The visited logical expression
        def visit_logical_expression(ctx)
          ctx__expression = ctx.expression

          visit_if(ctx__expression)
        end

        # Visit multiplication-like operator (*, /, DIV, MOD, AND, ||)
        # @param ctx [Ctx] The context containing the operator
        # @return [Symbol] The operator constant
        def visit_multiplication_like_op(ctx)
          ctx__text = ctx.values[0].text
          ctx__MULTIPLICATION = ctx__text == "*"
          ctx__REAL_DIVISION = ctx__text == "/"
          ctx__INTEGER_DIVISION = ctx.tDIV
          ctx__MODULO = ctx.tMOD
          ctx__AND = ctx.tAND
          ctx__COMBINE = ctx__text == "||"

          if ctx__MULTIPLICATION
            Model::Expressions::BinaryExpression::MULTIPLICATION
          elsif ctx__REAL_DIVISION
            Model::Expressions::BinaryExpression::REAL_DIVISION
          elsif ctx__INTEGER_DIVISION
            Model::Expressions::BinaryExpression::INTEGER_DIVISION
          elsif ctx__MODULO
            Model::Expressions::BinaryExpression::MODULO
          elsif ctx__AND
            Model::Expressions::BinaryExpression::AND
          elsif ctx__COMBINE
            Model::Expressions::BinaryExpression::COMBINE
          else
            raise Error::VisitorInvalidStateError.new("visit_multiplication_like_op called with invalid context")
          end
        end

        # Visit parameter (expression)
        # @param ctx [Ctx] The context containing the parameter
        # @return [Object] The visited parameter
        def visit_parameter(ctx)
          ctx__expression = ctx.expression

          visit_if(ctx__expression)
        end

        # Visit primary (literal or qualified factor)
        # @param ctx [Ctx] The context containing the primary
        # @return [Object] The visited primary
        def visit_primary(ctx)
          ctx__literal = ctx.literal
          ctx__qualifiable_factor = ctx.qualifiable_factor
          ctx__qualifier = ctx.qualifier

          if ctx__literal
            visit(ctx__literal)
          elsif ctx__qualifiable_factor
            handle_qualified_ref(visit(ctx__qualifiable_factor), ctx__qualifier)
          else
            raise Error::VisitorInvalidStateError.new("visit_primary called with invalid context")
          end
        end

        # Visit qualifiable factor
        # @param ctx [Ctx] The context containing the qualifiable factor
        # @return [Object] The visited factor
        def visit_qualifiable_factor(ctx)
          ctx__attribute_ref = ctx.attribute_ref
          ctx__constant_factor = ctx.constant_factor
          ctx__function_call = ctx.function_call
          ctx__general_ref = ctx.general_ref
          ctx__population = ctx.population

          visit_if(ctx__attribute_ref || ctx__constant_factor || ctx__function_call || ctx__general_ref || ctx__population)
        end

        # Visit qualified attribute (SELF.attribute)
        # @param ctx [Ctx] The context containing the qualified attribute
        # @return [Model::References::AttributeReference] The attribute reference
        def visit_qualified_attribute(ctx)
          ctx__group_qualifier = ctx.group_qualifier
          ctx__attribute_qualifier = ctx.attribute_qualifier

          id = "SELF"
          group_reference = visit_if(ctx__group_qualifier)
          attribute_reference = visit_if(ctx__attribute_qualifier)

          Model::References::AttributeReference.new(
            ref: Model::References::GroupReference.new(
              ref: Model::References::SimpleReference.new(
                id: id,
              ),
              entity: group_reference.entity, # reuse
            ),
            attribute: attribute_reference.attribute, # reuse
          )
        end

        # Visit query expression
        # @param ctx [Ctx] The context containing the query expression
        # @return [Model::Expressions::QueryExpression] The query expression
        def visit_query_expression(ctx)
          ctx__variable_id = ctx.variable_id
          ctx__aggregate_source = ctx.aggregate_source
          ctx__logical_expression = ctx.logical_expression

          id = visit_if(ctx__variable_id)
          aggregate_source = visit_if(ctx__aggregate_source)
          expression = visit_if(ctx__logical_expression)

          Model::Expressions::QueryExpression.new(
            id: id,
            aggregate_source: aggregate_source,
            expression: expression,
          )
        end

        # Visit relational operator (<, >, <=, >=, <>, =, :<>:, :=:)
        # @param ctx [Ctx] The context containing the operator
        # @return [Symbol] The operator constant
        def visit_rel_op(ctx)
          ctx__text = ctx.values[0].text
          ctx__LESS_THAN = ctx__text == "<"
          ctx__GREATER_THAN = ctx__text == ">"
          ctx__LESS_THAN_OR_EQUAL = ctx__text == "<="
          ctx__GREATER_THAN_OR_EQUAL = ctx__text == ">="
          ctx__NOT_EQUAL = ctx__text == "<>"
          ctx__EQUAL = ctx__text == "="
          ctx__INSTANCE_NOT_EQUAL = ctx__text == ":<>:"
          ctx__INSTANCE_EQUAL = ctx__text == ":=:"

          if ctx__LESS_THAN
            Model::Expressions::BinaryExpression::LESS_THAN
          elsif ctx__GREATER_THAN
            Model::Expressions::BinaryExpression::GREATER_THAN
          elsif ctx__LESS_THAN_OR_EQUAL
            Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL
          elsif ctx__GREATER_THAN_OR_EQUAL
            Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL
          elsif ctx__NOT_EQUAL
            Model::Expressions::BinaryExpression::NOT_EQUAL
          elsif ctx__EQUAL
            Model::Expressions::BinaryExpression::EQUAL
          elsif ctx__INSTANCE_NOT_EQUAL
            Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL
          elsif ctx__INSTANCE_EQUAL
            Model::Expressions::BinaryExpression::INSTANCE_EQUAL
          else
            raise Error::VisitorInvalidStateError.new("visit_rel_op called with invalid context")
          end
        end

        # Visit extended relational operator (includes IN and LIKE)
        # @param ctx [Ctx] The context containing the operator
        # @return [Symbol] The operator constant
        def visit_rel_op_extended(ctx)
          ctx__rel_op = ctx.rel_op
          ctx__IN = ctx.tIN
          ctx__LIKE = ctx.tLIKE

          if ctx__rel_op
            visit(ctx__rel_op)
          elsif ctx__IN
            Model::Expressions::BinaryExpression::IN
          elsif ctx__LIKE
            Model::Expressions::BinaryExpression::LIKE
          else
            raise Error::VisitorInvalidStateError.new("visit_rel_op_extended called with invalid context")
          end
        end

        # Visit simple expression (addition/subtraction chain)
        # @param ctx [Ctx] The context containing the simple expression
        # @return [Object] The visited expression
        def visit_simple_expression(ctx)
          ctx__term = [ctx.term] + ctx.rhs.map(&:term)
          ctx__add_like_op = ctx.rhs.map { |item| item.operator.values[0] }

          if ctx__term
            if ctx__term.length >= 2
              if ctx__add_like_op && (ctx__add_like_op.length == ctx__term.length - 1)
                operands = ctx__term.map { |item| visit(item) }
                operators = ctx__add_like_op.map { |item| visit(item) }

                handle_binary_expression(operands, operators)
              else
                raise Error::VisitorInvalidStateError.new("visit_simple_expression called with invalid context")
              end
            elsif ctx__term.length == 1
              visit(ctx__term[0])
            else
              raise Error::VisitorInvalidStateError.new("visit_simple_expression called with invalid context")
            end
          end
        end

        # Visit simple factor
        # @param ctx [Ctx] The context containing the simple factor
        # @return [Object] The visited simple factor
        def visit_simple_factor(ctx)
          ctx__aggregate_initializer = ctx.aggregate_initializer
          ctx__entity_constructor = ctx.entity_constructor
          ctx__enumeration_reference = ctx.enumeration_reference
          ctx__interval = ctx.interval
          ctx__query_expression = ctx.query_expression
          ctx__simple_factor_expression = ctx.simple_factor_expression
          ctx__simple_factor_unary_expression = ctx.simple_factor_unary_expression

          visit_if(ctx__aggregate_initializer || ctx__entity_constructor ||
                   ctx__enumeration_reference || ctx__interval ||
                   ctx__query_expression || ctx__simple_factor_expression ||
                   ctx__simple_factor_unary_expression)
        end

        # Visit simple factor expression
        # @param ctx [Ctx] The context containing the expression
        # @return [Object] The visited expression
        def visit_simple_factor_expression(ctx)
          ctx__expression = ctx.expression
          ctx__primary = ctx.primary

          visit_if(ctx__expression || ctx__primary)
        end

        # Visit simple factor unary expression
        # @param ctx [Ctx] The context containing the unary expression
        # @return [Model::Expressions::UnaryExpression] The unary expression
        def visit_simple_factor_unary_expression(ctx)
          ctx__unary_op = ctx.unary_op
          ctx__simple_factor_expression = ctx.simple_factor_expression

          operator = visit_if(ctx__unary_op)
          operand = visit_if(ctx__simple_factor_expression)

          Model::Expressions::UnaryExpression.new(
            operator: operator,
            operand: operand,
          )
        end

        # Visit term (multiplication/division chain)
        # @param ctx [Ctx] The context containing the term
        # @return [Object] The visited term
        def visit_term(ctx)
          ctx__factor = [ctx.factor] + ctx.rhs.map(&:factor)
          ctx__multiplication_like_op = ctx.rhs.map(&:multiplication_like_op)

          if ctx__factor
            if ctx__factor.length >= 2
              if ctx__multiplication_like_op && (ctx__multiplication_like_op.length == ctx__factor.length - 1)
                operands = ctx__factor.map { |item| visit(item) }
                operators = ctx__multiplication_like_op.map { |item| visit(item) }

                handle_binary_expression(operands, operators)
              else
                raise Error::VisitorInvalidStateError.new("visit_term called with invalid context")
              end
            elsif ctx__factor.length == 1
              visit(ctx__factor[0])
            else
              raise Error::VisitorInvalidStateError.new("visit_term called with invalid context")
            end
          end
        end

        # Visit unary operator (+, -, NOT)
        # @param ctx [Ctx] The context containing the operator
        # @return [Symbol] The operator constant
        def visit_unary_op(ctx)
          ctx__text = ctx.values[0].text
          ctx__PLUS = ctx__text == "+"
          ctx__MINUS = ctx__text == "-"
          ctx__NOT = ctx.tNOT

          if ctx__PLUS
            Model::Expressions::UnaryExpression::PLUS
          elsif ctx__MINUS
            Model::Expressions::UnaryExpression::MINUS
          elsif ctx__NOT
            Model::Expressions::UnaryExpression::NOT
          else
            raise Error::VisitorInvalidStateError.new("visit_unary_op called with invalid context")
          end
        end
      end
    end
  end
end
