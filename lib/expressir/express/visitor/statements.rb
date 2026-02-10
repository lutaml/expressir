# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module Statements
        private

      def visit_alias_stmt(ctx)
        ctx__variable_id = ctx.variable_id
        ctx__general_ref = ctx.general_ref
        ctx__qualifier = ctx.qualifier
        ctx__stmt = ctx.stmt

        id = visit_if(ctx__variable_id)
        expression = handle_qualified_ref(visit_if(ctx__general_ref),
                                          ctx__qualifier)
        statements = visit_if_map(ctx__stmt)

        Model::Statements::Alias.new(
          id: id,
          expression: expression,
          statements: statements,
        )
      end

      def visit_assignment_stmt(ctx)
        ctx__general_ref = ctx.general_ref
        ctx__qualifier = ctx.qualifier
        ctx__expression = ctx.expression

        ref = handle_qualified_ref(visit_if(ctx__general_ref), ctx__qualifier)
        expression = visit_if(ctx__expression)

        Model::Statements::Assignment.new(
          ref: ref,
          expression: expression,
        )
      end

      def visit_case_action(ctx)
        ctx__case_label = ctx.case_label
        ctx__stmt = ctx.stmt

        labels = visit_if_map(ctx__case_label)
        statement = visit_if(ctx__stmt)

        Model::Statements::CaseAction.new(
          labels: labels,
          statement: statement,
        )
      end

      def visit_case_label(ctx)
        ctx__expression = ctx.expression

        visit_if(ctx__expression)
      end

      def visit_case_stmt(ctx)
        ctx__selector = ctx.selector
        ctx__case_action = ctx.case_action
        ctx__stmt = ctx.stmt
        ctx__selector__expression = ctx__selector&.expression

        expression = visit_if(ctx__selector__expression)
        actions = visit_if_map_flatten(ctx__case_action)
        otherwise_statement = visit_if(ctx__stmt)

        Model::Statements::Case.new(
          expression: expression,
          actions: actions,
          otherwise_statement: otherwise_statement,
        )
      end

      def visit_compound_stmt(ctx)
        ctx__stmt = ctx.stmt

        statements = visit_if_map(ctx__stmt)

        Model::Statements::Compound.new(
          statements: statements,
        )
      end

      def visit_escape_stmt(_ctx)
        Model::Statements::Escape.new
      end

      def visit_if_stmt(ctx)
        ctx__logical_expression = ctx.logical_expression
        ctx__if_stmt_statements = ctx.if_stmt_statements
        ctx__if_stmt_else_statements = ctx.if_stmt_else_statements

        expression = visit_if(ctx__logical_expression)
        statements = visit_if(ctx__if_stmt_statements, [])
        else_statements = visit_if(ctx__if_stmt_else_statements, [])

        Model::Statements::If.new(
          expression: expression,
          statements: statements,
          else_statements: else_statements,
        )
      end

      def visit_if_stmt_statements(ctx)
        ctx__stmt = ctx.stmt

        visit_if_map(ctx__stmt)
      end

      def visit_if_stmt_else_statements(ctx)
        ctx__stmt = ctx.stmt

        visit_if_map(ctx__stmt)
      end

      def visit_null_stmt(_ctx)
        Model::Statements::Null.new
      end

      def visit_procedure_call_stmt(ctx)
        ctx__built_in_procedure = ctx.built_in_procedure
        ctx__procedure_ref = ctx.procedure_ref
        ctx__actual_parameter_list = ctx.actual_parameter_list

        procedure = visit_if(ctx__built_in_procedure || ctx__procedure_ref)
        parameters = visit_if(ctx__actual_parameter_list, [])

        Model::Statements::ProcedureCall.new(
          procedure: procedure,
          parameters: parameters,
        )
      end

      def visit_repeat_control(ctx)
        SimpleCtx === ctx ? to_ctx({}, :repeatControl) : ctx
      end

      def visit_repeat_stmt(ctx)
        ctx__repeat_control = visit ctx.repeat_control
        ctx__stmt = ctx.stmt
        ctx__repeat_control__increment_control = ctx__repeat_control&.increment_control
        ctx__repeat_control__increment_control__variable_id = ctx__repeat_control__increment_control&.variable_id
        ctx__repeat_control__increment_control__bound1 = ctx__repeat_control__increment_control&.bound1
        ctx__repeat_control__increment_control__bound2 = ctx__repeat_control__increment_control&.bound2
        ctx__repeat_control__increment_control__increment = ctx__repeat_control__increment_control&.increment
        ctx__repeat_control__while_control = ctx__repeat_control&.while_control
        ctx__repeat_control__until_control = ctx__repeat_control&.until_control

        id = visit_if(ctx__repeat_control__increment_control__variable_id)
        bound1 = visit_if(ctx__repeat_control__increment_control__bound1)
        bound2 = visit_if(ctx__repeat_control__increment_control__bound2)
        increment = visit_if(ctx__repeat_control__increment_control__increment)
        while_expression = visit_if(ctx__repeat_control__while_control)
        until_expression = visit_if(ctx__repeat_control__until_control)
        statements = visit_if_map(ctx__stmt)

        Model::Statements::Repeat.new(
          id: id,
          bound1: bound1,
          bound2: bound2,
          increment: increment,
          while_expression: while_expression,
          until_expression: until_expression,
          statements: statements,
        )
      end

      def visit_return_stmt(ctx)
        ctx__expression = ctx.expression

        expression = visit_if(ctx__expression)

        Model::Statements::Return.new(
          expression: expression,
        )
      end

      def visit_skip_stmt(_ctx)
        Model::Statements::Skip.new
      end

      def visit_stmt(ctx)
        ctx__alias_stmt = ctx.alias_stmt
        ctx__assignment_stmt = ctx.assignment_stmt
        ctx__case_stmt = ctx.case_stmt
        ctx__compound_stmt = ctx.compound_stmt
        ctx__escape_stmt = ctx.escape_stmt
        ctx__if_stmt = ctx.if_stmt
        ctx__null_stmt = ctx.null_stmt
        ctx__procedure_call_stmt = ctx.procedure_call_stmt
        ctx__repeat_stmt = ctx.repeat_stmt
        ctx__return_stmt = ctx.return_stmt
        ctx__skip_stmt = ctx.skip_stmt

        visit_if(ctx__alias_stmt || ctx__assignment_stmt || ctx__case_stmt ||
                 ctx__compound_stmt || ctx__escape_stmt || ctx__if_stmt ||
                 ctx__null_stmt || ctx__procedure_call_stmt ||
                 ctx__repeat_stmt || ctx__return_stmt || ctx__skip_stmt)
      end

      def visit_until_control(ctx)
        ctx__logical_expression = ctx.logical_expression

        visit_if(ctx__logical_expression)
      end

      def visit_while_control(ctx)
        ctx__logical_expression = ctx.logical_expression

        visit_if(ctx__logical_expression)
      end

      end
    end
  end
end
