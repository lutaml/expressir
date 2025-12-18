module Expressir
  module Express
    module StatementsFormatter
      private

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
          *format_remarks(node),
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
          *if node.otherwise_statement
             [
               [
                 "OTHERWISE",
                 " ",
                 ":",
               ].join,
               indent(format(node.otherwise_statement)),
             ]
           end,
          [
            "END_CASE",
            ";",
          ].join,
        ].join("\n")
      end

      def format_statements_case_action(node)
        node.labels ||= []
        [
          [
            node.labels.map { |x| format(x) }.join(", "),
            " ",
            ":",
          ].join,
          indent(format(node.statement)),
        ].join("\n")
      end

      def format_statements_compound(node)
        node.statements ||= []
        [
          "BEGIN",
          *if node.statements&.length&.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
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
          *if node.else_statements&.length&.positive?
             [
               "ELSE",
               indent(node.else_statements.map { |x| format(x) }.join("\n")),
             ].join("\n")
           end,
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
        node.statements ||= []
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
          *if node.statements&.length&.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          *format_remarks(node),
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
