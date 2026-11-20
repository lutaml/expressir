module Expressir
  module Express
    module Formatters
      module StatementsFormatter
        def self.included(base)
          base.register_formatter Model::Statements::Alias,
                                  :format_statements_alias
          base.register_formatter Model::Statements::Assignment,
                                  :format_statements_assignment
          base.register_formatter Model::Statements::Case,
                                  :format_statements_case
          base.register_formatter Model::Statements::CaseAction,
                                  :format_statements_case_action
          base.register_formatter Model::Statements::Compound,
                                  :format_statements_compound
          base.register_formatter Model::Statements::Escape,
                                  :format_statements_escape
          base.register_formatter Model::Statements::If, :format_statements_if
          base.register_formatter Model::Statements::Null,
                                  :format_statements_null
          base.register_formatter Model::Statements::ProcedureCall,
                                  :format_statements_procedure_call
          base.register_formatter Model::Statements::Repeat,
                                  :format_statements_repeat
          base.register_formatter Model::Statements::Return,
                                  :format_statements_return
          base.register_formatter Model::Statements::Skip,
                                  :format_statements_skip
        end

        def format_statements_alias(node)
          [
            [
              "ALIAS",
              " ",
              node.id,
              " ",
              "FOR",
              " ",
              format(node.expression),
              ";",
            ].join,
            *if node.statements&.length&.positive?
               indent(node.statements.map { |x| format(x) }.join("\n"))
             end,
            *format_block_end_remarks(node).map { |x| indent(x) },
            [
              "END_ALIAS",
              ";",
            ].join,
          ].join("\n")
        end

        def format_statements_assignment(node)
          [
            format(node.ref),
            " ",
            ":=",
            " ",
            format(node.expression),
            ";",
          ].join
        end

        def format_statements_procedure_call(node)
          [
            format(node.procedure),
            *if node.parameters&.length&.positive?
               [
                 "(",
                 node.parameters.map { |x| format(x) }.join(", "),
                 ")",
               ].join
             end,
            ";",
          ].join
        end

        def format_statements_case(node)
          [
            [
              "CASE",
              " ",
              format(node.expression),
              " ",
              "OF",
            ].join,
            *if node.actions&.length&.positive?
               node.actions.map { |x| format(x) }
             end,
            # Closes the last action: before OTHERWISE when one exists,
            # otherwise before END_CASE.
            *format_trailing_region_remarks(node, :action_statements)
              .map { |x| indent(x) },
            *if node.otherwise_statement
               [
                 [
                   "OTHERWISE",
                   " ",
                   ":",
                   format_mid_keyword_remarks(node,
                                              Model::RemarkPlacement::OTHERWISE_REGION),
                 ].join,
                 indent(format(node.otherwise_statement)),
               ]
             end,
            *format_trailing_region_remarks(node, :otherwise_statements)
              .map { |x| indent(x) },
            [
              "END_CASE",
              ";",
            ].join,
          ].join("\n")
        end

        def format_statements_case_action(node)
          [
            [
              Array(node.labels).map { |x| format(x) }.join(", "),
              " ",
              ":",
              case_label_remark(node),
            ].join,
            indent(format(node.statement)),
          ].join("\n")
        end

        # A remark trailing a bare case label (`1 : -- why`, the action on
        # the next line) is owned by the CASE with the label region; it
        # belongs back on the label line of the action it precedes (#693).
        # Matched by offset when the remark carries one; otherwise by order —
        # the k-th label remark precedes the k-th action (both read in source
        # order).
        def case_label_remark(action)
          case_node = action.parent
          return "" unless case_node.is_a?(Model::Statements::Case)

          actions = Array(case_node.actions)
          index = actions.index { |a| a.equal?(action) }
          return "" unless index

          label_remarks = Array(case_node.untagged_remarks)
            .select { |r| r.inline? && r.region == Model::RemarkPlacement::LABEL_REGION }
          remark =
            if label_remarks.first&.source_offset
              anchor = Array(action.labels).filter_map(&:source_offset).min
              bound = actions[(index + 1)..]
                .filter_map { |a| Array(a.labels).filter_map(&:source_offset).min }
                .min
              return "" unless anchor

              label_remarks.find do |r|
                r.source_offset && r.source_offset >= anchor &&
                  (bound.nil? || r.source_offset < bound)
              end
            else
              label_remarks[index]
            end
          return "" unless remark

          formatted = format_untagged_remark(remark)
          formatted.empty? ? "" : " #{formatted}"
        end

        def format_statements_compound(node)
          statements = Array(node.statements)
          [
            "BEGIN",
            *if statements.length.positive?
               indent(statements.map { |x| format(x) }.join("\n"))
             end,
            *format_trailing_region_remarks(node, :statements).map { |x| indent(x) },
            [
              "END",
              ";",
            ].join,
          ].join("\n")
        end

        def format_statements_escape(_node)
          [
            "ESCAPE",
            ";",
          ].join
        end

        def format_statements_if(node)
          has_else = node.else_statements&.length&.positive?
          # A comment closing the THEN body sits before ELSE when there is
          # one, and before END_IF otherwise.
          then_trailing = format_trailing_region_remarks(node, :statements)
            .map { |x| indent(x) }
          else_trailing = format_trailing_region_remarks(node, :else_statements)
            .map { |x| indent(x) }

          [
            [
              "IF",
              " ",
              format(node.expression),
              " ",
              "THEN",
            ].join,
            *if node.statements&.length&.positive?
               indent(node.statements.map { |x| format(x) }.join("\n"))
             end,
            *(then_trailing if has_else),
            *if has_else
               [
                 [
                   "ELSE",
                   format_mid_keyword_remarks(node,
                                              Model::RemarkPlacement::ELSE_REGION),
                 ].join,
                 indent(node.else_statements.map { |x| format(x) }.join("\n")),
               ].join("\n")
             end,
            *(has_else ? else_trailing : then_trailing),
            [
              "END_IF",
              ";",
            ].join,
          ].join("\n")
        end

        def format_statements_null(_node)
          ";"
        end

        def format_statements_repeat(node)
          statements = Array(node.statements)
          [
            [
              "REPEAT",
              *if node.id
                 [
                   " ",
                   node.id,
                   " ",
                   ":=",
                   " ",
                   format(node.bound1),
                   " ",
                   "TO",
                   " ",
                   format(node.bound2),
                   *if node.increment
                      [
                        " ",
                        "BY",
                        " ",
                        format(node.increment),
                      ].join
                    end,
                 ].join
               end,
              *if node.while_expression
                 [
                   " ",
                   "WHILE",
                   " ",
                   format(node.while_expression),
                 ].join
               end,
              *if node.until_expression
                 [
                   " ",
                   "UNTIL",
                   " ",
                   format(node.until_expression),
                 ].join
               end,
              ";",
            ].join,
            *if statements.length.positive?
               indent(statements.map { |x| format(x) }.join("\n"))
             end,
            *format_block_end_remarks(node).map { |x| indent(x) },
            [
              "END_REPEAT",
              ";",
            ].join,
          ].join("\n")
        end

        def format_statements_return(node)
          [
            "RETURN",
            *if node.expression
               [
                 " ",
                 "(",
                 format(node.expression),
                 ")",
               ].join
             end,
            ";",
          ].join
        end

        def format_statements_skip(_node)
          [
            "SKIP",
            ";",
          ].join
        end
      end
    end
  end
end
