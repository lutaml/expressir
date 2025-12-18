module Expressir
  module Express
    module DeclarationsFormatter
      private

      def format_declarations_attribute(node)
        [
          *if node.supertype_attribute
             [
               format(node.supertype_attribute),
               " ",
             ].join
           end,
          *if node.supertype_attribute && node.id != node.supertype_attribute.attribute.id
             [
               "RENAMED",
               " ",
               node.id,
               " ",
             ].join
           end,
          *if node.id && !node.supertype_attribute
             [
               node.id,
               " ",
             ].join
           end,
          ":",
          *if node.optional
             [
               " ",
               "OPTIONAL",
             ].join
           end,
          " ",
          format(node.type),
          *if node.kind == Model::Declarations::Attribute::DERIVED
             [
               " ",
               ":=",
               " ",
               format(node.expression),
             ].join
           elsif node.kind == Model::Declarations::Attribute::INVERSE
             [
               " ",
               "FOR",
               " ",
               format(node.expression),
             ].join
           end,
          ";",
          format_inline_tail_remark(node),
        ].join
      end

      def format_declarations_constant(node)
        [
          node.id,
          " ",
          ":",
          " ",
          format(node.type),
          " ",
          ":=",
          " ",
          format(node.expression),
          ";",
        ].join
      end

      def format_declarations_entity(node)
        if node.attributes.nil?
          explicit_attributes = []
          derived_attributes = []
          inverse_attributes = []
        else
          explicit_attributes = node.attributes.select do |x|
            x.kind == Model::Declarations::Attribute::EXPLICIT
          end
          derived_attributes = node.attributes.select do |x|
            x.kind == Model::Declarations::Attribute::DERIVED
          end
          inverse_attributes = node.attributes.select do |x|
            x.kind == Model::Declarations::Attribute::INVERSE
          end
        end

        indent_const = self.class.const_get(:INDENT)
        # Only show preamble remarks if entity has explicit attributes
        preamble = if explicit_attributes&.length&.positive?
                     format_preamble_remarks(node, indent(indent_const))
                   end

        [
          [
            "ENTITY",
            " ",
            node.id,
            *if node.abstract && !node.supertype_expression
               [
                 "\n",
                 indent([
                   "ABSTRACT",
                   " ",
                   "SUPERTYPE",
                 ].join),
               ].join
             end,
            *if node.abstract && node.supertype_expression
               [
                 "\n",
                 indent([
                   "ABSTRACT",
                   " ",
                   "SUPERTYPE",
                   " ",
                   "OF",
                   " ",
                   "(",
                   format(node.supertype_expression),
                   ")",
                 ].join),
               ].join
             end,
            *if !node.abstract && node.supertype_expression
               [
                 "\n",
                 indent([
                   "SUPERTYPE",
                   " ",
                   "OF",
                   " ",
                   "(",
                   format(node.supertype_expression),
                   ")",
                 ].join),
               ].join
             end,
            *if node.subtype_of&.length&.positive?
               [
                 "\n",
                 indent([
                   "SUBTYPE",
                   " ",
                   "OF",
                   " ",
                   "(",
                   node.subtype_of.map { |x| format(x) }.join(", "),
                   ")",
                 ].join),
               ].join
             end,
            ";",
          ].join,
          *if preamble && !preamble.empty?
             preamble.rstrip
           end,
          *if explicit_attributes&.length&.positive?
             indent(explicit_attributes.map { |x| format(x) }.join("\n"))
           end,
          *if derived_attributes&.length&.positive?
             [
               "DERIVE",
               indent(derived_attributes.map { |x| format(x) }.join("\n")),
             ]
           end,
          *if inverse_attributes&.length&.positive?
             [
               "INVERSE",
               indent(inverse_attributes.map { |x| format(x) }.join("\n")),
             ]
           end,
          *if node.unique_rules&.length&.positive?
             [
               "UNIQUE",
               indent(node.unique_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          *if node.where_rules&.length&.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_ENTITY",
            ";",
            # Only show end_scope_remark if entity has explicit attributes
            explicit_attributes&.length&.positive? ? format_end_scope_remark(node) : "",
          ].join,
        ].join("\n")
      end

      def format_declarations_function(node)
        indent_char = self.class.const_get(:INDENT_CHAR)
        [
          [
            "FUNCTION",
            " ",
            node.id,
            *if node.parameters&.length&.positive?
               parameter_indent = indent_char * "FUNCTION #{node.id}(".length
               [
                 "(",
                 node.parameters.map do |x|
                   format(x)
                 end.join(";\n#{parameter_indent}"),
                 ")",
               ].join
             end,
            " ",
            ":",
            " ",
            format(node.return_type),
            ";",
          ].join,
          *if node.types&.length&.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities&.length&.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints&.length&.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions&.length&.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures&.length&.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants&.length&.positive?
             indent([
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.variables&.length&.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.statements&.length&.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          [
            "END_FUNCTION",
            ";",
          ].join,
        ].join("\n")
      end

      def format_declarations_interface(node)
        indent_char = self.class.const_get(:INDENT_CHAR)
        [
          case node.kind
          when Model::Declarations::Interface::USE then "USE"
          when Model::Declarations::Interface::REFERENCE then "REFERENCE"
          end,
          " ",
          "FROM",
          " ",
          format(node.schema),
          *if node.items&.length&.positive?
             item_indent = indent_char * "(".length
             [
               "\n",
               indent([
                 "(",
                 node.items.map { |x| format(x) }.join(",\n#{item_indent}"),
                 ")",
               ].join),
             ].join
           end,
          ";",
        ].join
      end

      def format_declarations_interface_item(node)
        [
          format(node.ref),
          *if node.id
             [
               " ",
               "AS",
               " ",
               node.id,
             ]
           end,
        ].join
      end

      def format_declarations_parameter(node)
        [
          *if node.var
             [
               "VAR",
               " ",
             ].join
           end,
          node.id,
          " ",
          ":",
          " ",
          format(node.type),
        ].join
      end

      def format_declarations_procedure(node)
        indent_char = self.class.const_get(:INDENT_CHAR)
        [
          [
            "PROCEDURE",
            " ",
            node.id,
            *if node.parameters&.length&.positive?
               parameter_indent = indent_char * "PROCEDURE #{node.id}(".length
               [
                 "(",
                 node.parameters.map do |x|
                   format(x)
                 end.join(";\n#{parameter_indent}"),
                 ")",
               ].join
             end,
            ";",
          ].join,
          *if node.types&.length&.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities&.length&.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints&.length&.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions&.length&.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures&.length&.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants&.length&.positive?
             indent([
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.variables&.length&.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.statements&.length&.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          [
            "END_PROCEDURE",
            ";",
          ].join,
        ].join("\n")
      end

      def format_declarations_rule(node)
        node.applies_to ||= []

        # Filter out statements that only exist to hold remarks in rules
        # (ALIAS/REPEAT with only Null sub-statements, query assignments, or Null statements)
        formatted_statements = []
        if node.statements&.length&.positive?
          formatted_statements = node.statements.reject do |stmt|
            # Filter ALIAS/REPEAT with only Null statements
            if (stmt.is_a?(Model::Statements::Alias) || stmt.is_a?(Model::Statements::Repeat))
              stmt.statements&.all? { |s| s.is_a?(Model::Statements::Null) }
            # Filter query assignments (assignments with QueryExpression that exist only for remarks)
            elsif stmt.is_a?(Model::Statements::Assignment) &&
                  stmt.expression.is_a?(Model::Expressions::QueryExpression)
              true
            # Filter Null statements
            elsif stmt.is_a?(Model::Statements::Null)
              true
            else
              false
            end
          end
        end

        [
          [
            "RULE",
            " ",
            node.id,
            " ",
            "FOR",
            " ",
            "(",
            node.applies_to.map { |x| format(x) }.join(", "),
            ")",
            ";",
          ].join,
          *if node.types&.length&.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities&.length&.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints&.length&.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions&.length&.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures&.length&.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants&.length&.positive?
             indent([
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.variables&.length&.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if formatted_statements.length.positive?
             indent(formatted_statements.map { |x| format(x) }.join("\n"))
           end,
          *if node.where_rules&.length&.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_RULE",
            ";",
          ].join,
        ].join("\n")
      end

      def format_declarations_schema_head(node)
        [
          [
            "SCHEMA",
            " ",
            node.id,
            *if node.version
               [
                 " ",
                 format(node.version),
               ].join
             end,
            ";",
          ].join,
          *if node.interfaces&.length&.positive?
             [
               "",
               node.interfaces.map { |x| format(x) }.join("\n"),
             ]
           end,
        ].join("\n")
      end

      def format_declarations_schema(node)
        indent_const = self.class.const_get(:INDENT)
        preamble = format_preamble_remarks(node, indent(indent_const))

        schema_declarations = [
          *if node.constants&.length&.positive?
             [
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n")
           end,
          *if node.types&.length&.positive?
             node.types.map { |x| format(x) }
           end,
          *if node.entities&.length&.positive?
             node.entities.map { |x| format(x) }
           end,
          *if node.subtype_constraints&.length&.positive?
             node.subtype_constraints.map { |x| format(x) }
           end,
          *if node.functions&.length&.positive?
             node.functions.map { |x| format(x) }
           end,
          *if node.rules&.length&.positive?
             node.rules.map { |x| format(x) }
           end,
          *if node.procedures&.length&.positive?
             node.procedures.map { |x| format(x) }
           end,
        ]

        [
          format_declarations_schema_head(node),
          *if preamble && !preamble.empty?
             [
               "",
               preamble.rstrip,
               "",
             ]
           end,
          *if schema_declarations&.length&.positive?
             [
               "",
               schema_declarations.join("\n\n"),
               "",
             ]
           end,
          [
            "END_SCHEMA",
            ";",
          ].join,
          *format_scope_remarks(node),
        ].join("\n")
      end

      def format_declarations_schema_version(node)
        [
          "'",
          node.value,
          "'",
        ].join
      end

      def format_declarations_subtype_constraint(node)
        [
          [
            "SUBTYPE_CONSTRAINT",
            " ",
            node.id,
            " ",
            "FOR",
            " ",
            format(node.applies_to),
            ";",
          ].join,
          *if node.abstract
             indent([
               "ABSTRACT",
               " ",
               "SUPERTYPE",
               ";",
             ].join)
           end,
          *if node.total_over&.length&.positive?
             indent([
               "TOTAL_OVER",
               "(",
               node.total_over.map { |x| format(x) }.join(", "),
               ")",
               ";",
             ].join)
           end,
          *if node.supertype_expression
             indent([
               format(node.supertype_expression),
               ";",
             ].join)
           end,
          [
            "END_SUBTYPE_CONSTRAINT",
            ";",
          ].join,
        ].join("\n")
      end

      def format_declarations_type(node)
        [
          [
            "TYPE",
            " ",
            node.id,
            " ",
            "=",
            " ",
            format(node.underlying_type),
            ";",
          ].join,
          *if node.where_rules&.length&.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_TYPE",
            ";",
            format_end_scope_remark(node),
          ].join,
        ].join("\n")
      end

      def format_declarations_unique_rule(node)
        node.attributes ||= []
        [
          *if node.id
             [
               node.id,
               ":",
               " ",
             ].join
           end,
          node.attributes.map { |x| format(x) }.join(", "),
          ";",
        ].join
      end

      def format_declarations_variable(node)
        [
          node.id,
          " ",
          ":",
          " ",
          format(node.type),
          *if node.expression
             [
               " ",
               ":=",
               " ",
               format(node.expression),
             ].join
           end,
          ";",
        ].join
      end

      def format_declarations_where_rule(node)
        [
          *if node.id
             [
               node.id,
               ":",
               " ",
             ].join
           end,
          format(node.expression),
          ";",
        ].join
      end

      def format_declarations_informal_proposition_rule(node)
        [
          *if node.id
             [
               node.id,
               ":",
               " ",
             ].join
           end,
        ].join
      end
    end
  end
end