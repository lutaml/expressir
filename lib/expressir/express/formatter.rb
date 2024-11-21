require "expressir/model"

module Expressir
  module Express
    class Formatter
      INDENT_CHAR = " ".freeze
      INDENT_WIDTH = 2
      INDENT = INDENT_CHAR * INDENT_WIDTH
      OPERATOR_PRECEDENCE = {
        Model::Expressions::BinaryExpression::EXPONENTIATION => 1,
        Model::Expressions::BinaryExpression::MULTIPLICATION => 2,
        Model::Expressions::BinaryExpression::REAL_DIVISION => 2,
        Model::Expressions::BinaryExpression::INTEGER_DIVISION => 2,
        Model::Expressions::BinaryExpression::MODULO => 2,
        Model::Expressions::BinaryExpression::AND => 2,
        Model::Expressions::BinaryExpression::COMBINE => 2,
        Model::Expressions::BinaryExpression::SUBTRACTION => 3,
        Model::Expressions::BinaryExpression::ADDITION => 3,
        Model::Expressions::BinaryExpression::OR => 3,
        Model::Expressions::BinaryExpression::XOR => 3,
        Model::Expressions::BinaryExpression::EQUAL => 4,
        Model::Expressions::BinaryExpression::NOT_EQUAL => 4,
        Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL => 4,
        Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL => 4,
        Model::Expressions::BinaryExpression::LESS_THAN => 4,
        Model::Expressions::BinaryExpression::GREATER_THAN => 4,
        Model::Expressions::BinaryExpression::INSTANCE_EQUAL => 4,
        Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL => 4,
        Model::Expressions::BinaryExpression::IN => 4,
        Model::Expressions::BinaryExpression::LIKE => 4,
      }.freeze
      SUPERTYPE_OPERATOR_PRECEDENCE = {
        Model::SupertypeExpressions::BinarySupertypeExpression::AND => 1,
        Model::SupertypeExpressions::BinarySupertypeExpression::ANDOR => 2,
      }.freeze

      private_constant :INDENT_CHAR
      private_constant :INDENT_WIDTH
      private_constant :INDENT
      private_constant :OPERATOR_PRECEDENCE
      private_constant :SUPERTYPE_OPERATOR_PRECEDENCE

      # Formats Express model into an Express code
      # @param [Model::ModelElement] node
      # @return [String]
      def self.format(node)
        formatter = new
        formatter.format(node)
      end

      # Formats Express model into an Express code
      # @param [Model::ModelElement] node
      # @return [String]
      def format(node)
        case node
        when Model::Repository
          format_repository(node)
        when Model::Declarations::Attribute
          format_declarations_attribute(node)
        when Model::Declarations::Constant
          format_declarations_constant(node)
        when Model::Declarations::Entity
          format_declarations_entity(node)
        when Model::Declarations::Function
          format_declarations_function(node)
        when Model::Declarations::Interface
          format_declarations_interface(node)
        when Model::Declarations::InterfaceItem
          format_declarations_interface_item(node)
        when Model::Declarations::Parameter
          format_declarations_parameter(node)
        when Model::Declarations::Procedure
          format_declarations_procedure(node)
        when Model::Declarations::Rule
          format_declarations_rule(node)
        when Model::Declarations::Schema
          format_declarations_schema(node)
        when Model::Declarations::SchemaVersion
          format_declarations_schema_version(node)
        when Model::Declarations::SubtypeConstraint
          format_declarations_subtype_constraint(node)
        when Model::Declarations::Type
          format_declarations_type(node)
        when Model::Declarations::UniqueRule
          format_declarations_unique_rule(node)
        when Model::Declarations::Variable
          format_declarations_variable(node)
        when Model::Declarations::WhereRule
          format_declarations_where_rule(node)
        when Model::DataTypes::Aggregate
          format_data_types_aggregate(node)
        when Model::DataTypes::Array
          format_data_types_array(node)
        when Model::DataTypes::Bag
          format_data_types_bag(node)
        when Model::DataTypes::Binary
          format_data_types_binary(node)
        when Model::DataTypes::Boolean
          format_data_types_boolean(node)
        when Model::DataTypes::Enumeration
          format_data_types_enumeration(node)
        when Model::DataTypes::EnumerationItem
          format_data_types_enumeration_item(node)
        when Model::DataTypes::GenericEntity
          format_data_types_generic_entity(node)
        when Model::DataTypes::Generic
          format_data_types_generic(node)
        when Model::DataTypes::Integer
          format_data_types_integer(node)
        when Model::DataTypes::List
          format_data_types_list(node)
        when Model::DataTypes::Logical
          format_data_types_logical(node)
        when Model::DataTypes::Number
          format_data_types_number(node)
        when Model::DataTypes::Real
          format_data_types_real(node)
        when Model::DataTypes::Select
          format_data_types_select(node)
        when Model::DataTypes::Set
          format_data_types_set(node)
        when Model::DataTypes::String
          format_data_types_string(node)
        when Model::Expressions::AggregateInitializer
          format_expressions_aggregate_initializer(node)
        when Model::Expressions::AggregateInitializerItem
          format_expressions_aggregate_initializer_item(node)
        when Model::Expressions::BinaryExpression
          format_expressions_binary_expression(node)
        when Model::Expressions::EntityConstructor
          format_expressions_entity_constructor(node)
        when Model::Expressions::FunctionCall
          format_expressions_function_call(node)
        when Model::Expressions::Interval
          format_expressions_interval(node)
        when Model::Expressions::QueryExpression
          format_expressions_query_expression(node)
        when Model::Expressions::UnaryExpression
          format_expressions_unary_expression(node)
        when Model::Literals::Binary
          format_literals_binary(node)
        when Model::Literals::Integer
          format_literals_integer(node)
        when Model::Literals::Logical
          format_literals_logical(node)
        when Model::Literals::Real
          format_literals_real(node)
        when Model::Literals::String
          format_literals_string(node)
        when Model::References::AttributeReference
          format_references_attribute_reference(node)
        when Model::References::GroupReference
          format_references_group_reference(node)
        when Model::References::IndexReference
          format_references_index_reference(node)
        when Model::References::SimpleReference
          format_references_simple_reference(node)
        when Model::Statements::Alias
          format_statements_alias(node)
        when Model::Statements::Assignment
          format_statements_assignment(node)
        when Model::Statements::Case
          format_statements_case(node)
        when Model::Statements::CaseAction
          format_statements_case_action(node)
        when Model::Statements::Compound
          format_statements_compound(node)
        when Model::Statements::Escape
          format_statements_escape(node)
        when Model::Statements::If
          format_statements_if(node)
        when Model::Statements::Null
          format_statements_null(node)
        when Model::Statements::ProcedureCall
          format_statements_procedure_call(node)
        when Model::Statements::Repeat
          format_statements_repeat(node)
        when Model::Statements::Return
          format_statements_return(node)
        when Model::Statements::Skip
          format_statements_skip(node)
        when Model::SupertypeExpressions::BinarySupertypeExpression
          format_supertype_expressions_binary_supertype_expression(node)
        when Model::SupertypeExpressions::OneofSupertypeExpression
          format_supertype_expressions_oneof_supertype_expression(node)
        else
          warn "#{node.class.name} format not implemented"
          ""
        end
      end

      private

      def format_repository(node)
        node.schemas.map { |x| format(x) }.join("\n\n")
      end

      def format_declarations_attribute(node)
        [
          *if node.supertype_attribute
             [
               format(node.supertype_attribute),
               " ",
             ].join("")
           end,
          *if node.supertype_attribute && node.id
             [
               "RENAMED",
               " ",
             ].join("")
           end,
          *if node.id
             [
               node.id,
               " ",
             ].join("")
           end,
          ":",
          *if node.optional
             [
               " ",
               "OPTIONAL",
             ].join("")
           end,
          " ",
          format(node.type),
          *if node.kind == Model::Declarations::Attribute::DERIVED
             [
               " ",
               ":=",
               " ",
               format(node.expression),
             ].join("")
           elsif node.kind == Model::Declarations::Attribute::INVERSE
             [
               " ",
               "FOR",
               " ",
               format(node.expression),
             ].join("")
           end,
          ";",
        ].join("")
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
        ].join("")
      end

      def format_declarations_entity(node)
        explicit_attributes = node.attributes.select { |x| x.kind == Model::Declarations::Attribute::EXPLICIT }
        derived_attributes = node.attributes.select { |x| x.kind == Model::Declarations::Attribute::DERIVED }
        inverse_attributes = node.attributes.select { |x| x.kind == Model::Declarations::Attribute::INVERSE }

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
                 ].join("")),
               ].join("")
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
                 ].join("")),
               ].join("")
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
                 ].join("")),
               ].join("")
             end,
            *if node.subtype_of.length.positive?
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
                 ].join("")),
               ].join("")
             end,
            ";",
          ].join(""),
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
          *if node.unique_rules.length.positive?
             [
               "UNIQUE",
               indent(node.unique_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          *if node.where_rules.length.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_ENTITY",
            ";",
          ].join(""),
        ].join("\n")
      end

      def format_declarations_function(node)
        [
          [
            "FUNCTION",
            " ",
            node.id,
            *if node.parameters.length.positive?
               parameter_indent = INDENT_CHAR * "FUNCTION #{node.id}(".length
               [
                 "(",
                 node.parameters.map { |x| format(x) }.join(";\n#{parameter_indent}"),
                 ")",
               ].join("")
             end,
            " ",
            ":",
            " ",
            format(node.return_type),
            ";",
          ].join(""),
          *if node.types.length.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities.length.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints.length.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions.length.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures.length.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants.length.positive?
             indent([
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join(""),
             ].join("\n"))
           end,
          *if node.variables.length.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join(""),
             ].join("\n"))
           end,
          *if node.statements.length.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          [
            "END_FUNCTION",
            ";",
          ].join(""),
        ].join("\n")
      end

      def format_declarations_interface(node)
        [
          case node.kind
          when Model::Declarations::Interface::USE then "USE"
          when Model::Declarations::Interface::REFERENCE then "REFERENCE"
          end,
          " ",
          "FROM",
          " ",
          format(node.schema),
          *if node.items.length.positive?
             item_indent = INDENT_CHAR * "(".length
             [
               "\n",
               indent([
                 "(",
                 node.items.map { |x| format(x) }.join(",\n#{item_indent}"),
                 ")",
               ].join("")),
             ].join("")
           end,
          ";",
        ].join("")
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
        ].join("")
      end

      def format_declarations_parameter(node)
        [
          *if node.var
             [
               "VAR",
               " ",
             ].join("")
           end,
          node.id,
          " ",
          ":",
          " ",
          format(node.type),
        ].join("")
      end

      def format_declarations_procedure(node)
        [
          [
            "PROCEDURE",
            " ",
            node.id,
            *if node.parameters.length.positive?
               parameter_indent = INDENT_CHAR * "PROCEDURE #{node.id}(".length
               [
                 "(",
                 node.parameters.map { |x| format(x) }.join(";\n#{parameter_indent}"),
                 ")",
               ].join("")
             end,
            ";",
          ].join(""),
          *if node.types.length.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities.length.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints.length.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions.length.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures.length.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants.length.positive?
             indent([
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join(""),
             ].join("\n"))
           end,
          *if node.variables.length.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join(""),
             ].join("\n"))
           end,
          *if node.statements.length.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          [
            "END_PROCEDURE",
            ";",
          ].join(""),
        ].join("\n")
      end

      def format_declarations_rule(node)
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
          ].join(""),
          *if node.types.length.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities.length.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints.length.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions.length.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures.length.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants.length.positive?
             indent([
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join(""),
             ].join("\n"))
           end,
          *if node.variables.length.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join(""),
             ].join("\n"))
           end,
          *if node.statements.length.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          *if node.where_rules.length.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_RULE",
            ";",
          ].join(""),
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
               ].join("")
             end,
            ";",
          ].join(""),
          *if node.interfaces.length.positive?
             [
               "",
               node.interfaces.map { |x| format(x) }.join("\n"),
             ]
           end,
        ].join("\n")
      end

      def format_declarations_schema(node)
        schema_declarations = [
          *if node.constants.length.positive?
             [
               "CONSTANT",
               indent(node.constants.map { |x| format(x) }.join("\n")),
               [
                 "END_CONSTANT",
                 ";",
               ].join(""),
             ].join("\n")
           end,
          *if node.types.length.positive?
             node.types.map { |x| format(x) }
           end,
          *if node.entities.length.positive?
             node.entities.map { |x| format(x) }
           end,
          *if node.subtype_constraints.length.positive?
             node.subtype_constraints.map { |x| format(x) }
           end,
          *if node.functions.length.positive?
             node.functions.map { |x| format(x) }
           end,
          *if node.rules.length.positive?
             node.rules.map { |x| format(x) }
           end,
          *if node.procedures&.length&.positive?
             node.procedures.map { |x| format(x) }
           end,
        ]

        [
          format_declarations_schema_head(node),
          *if schema_declarations.length.positive?
             [
               "",
               schema_declarations.join("\n\n"),
               "",
             ]
           end,
          [
            "END_SCHEMA",
            ";",
          ].join(""),
          *format_scope_remarks(node),
        ].join("\n")
      end

      def format_declarations_schema_version(node)
        [
          "'",
          node.value,
          "'",
        ].join("")
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
          ].join(""),
          *if node.abstract
             indent([
               "ABSTRACT",
               " ",
               "SUPERTYPE",
               ";",
             ].join(""))
           end,
          *if node.total_over.length.positive?
             indent([
               "TOTAL_OVER",
               "(",
               node.total_over.map { |x| format(x) }.join(", "),
               ")",
               ";",
             ].join(""))
           end,
          *if node.supertype_expression
             indent([
               format(node.supertype_expression),
               ";",
             ].join(""))
           end,
          [
            "END_SUBTYPE_CONSTRAINT",
            ";",
          ].join(""),
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
          ].join(""),
          *if node.where_rules.length.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_TYPE",
            ";",
          ].join(""),
        ].join("\n")
      end

      def format_declarations_unique_rule(node)
        [
          *if node.id
             [
               node.id,
               ":",
               " ",
             ].join("")
           end,
          node.attributes.map { |x| format(x) }.join(", "),
          ";",
        ].join("")
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
             ].join("")
           end,
          ";",
        ].join("")
      end

      def format_declarations_where_rule(node)
        [
          *if node.id
             [
               node.id,
               ":",
               " ",
             ].join("")
           end,
          format(node.expression),
          ";",
        ].join("")
      end

      def format_expressions_aggregate_initializer(node)
        [
          "[",
          node.items.map { |x| format(x) }.join(", "),
          "]",
        ].join("")
      end

      def format_expressions_aggregate_initializer_item(node)
        [
          format(node.expression),
          ":",
          format(node.repetition),
        ].join("")
      end

      def format_expressions_binary_expression(node)
        [
          *if node.operand1.is_a?(Model::Expressions::BinaryExpression) && (OPERATOR_PRECEDENCE[node.operand1.operator] > OPERATOR_PRECEDENCE[node.operator])
             "("
           end,
          format(node.operand1),
          *if node.operand1.is_a?(Model::Expressions::BinaryExpression) && (OPERATOR_PRECEDENCE[node.operand1.operator] > OPERATOR_PRECEDENCE[node.operator])
             ")"
           end,
          " ",
          case node.operator
          when Model::Expressions::BinaryExpression::ADDITION then "+"
          when Model::Expressions::BinaryExpression::AND then "AND"
          when Model::Expressions::BinaryExpression::COMBINE then "||"
          when Model::Expressions::BinaryExpression::EQUAL then "="
          when Model::Expressions::BinaryExpression::EXPONENTIATION then "**"
          when Model::Expressions::BinaryExpression::GREATER_THAN then ">"
          when Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL then ">="
          when Model::Expressions::BinaryExpression::IN then "IN"
          when Model::Expressions::BinaryExpression::INSTANCE_EQUAL then ":=:"
          when Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL then ":<>:"
          when Model::Expressions::BinaryExpression::INTEGER_DIVISION then "DIV"
          when Model::Expressions::BinaryExpression::LESS_THAN then "<"
          when Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL then "<="
          when Model::Expressions::BinaryExpression::LIKE then "LIKE"
          when Model::Expressions::BinaryExpression::MODULO then "MOD"
          when Model::Expressions::BinaryExpression::MULTIPLICATION then "*"
          when Model::Expressions::BinaryExpression::NOT_EQUAL then "<>"
          when Model::Expressions::BinaryExpression::OR then "OR"
          when Model::Expressions::BinaryExpression::REAL_DIVISION then "/"
          when Model::Expressions::BinaryExpression::SUBTRACTION then "-"
          when Model::Expressions::BinaryExpression::XOR then "XOR"
          end,
          " ",
          *if node.operand2.is_a?(Model::Expressions::BinaryExpression) && (OPERATOR_PRECEDENCE[node.operand2.operator] > OPERATOR_PRECEDENCE[node.operator])
             "("
           end,
          format(node.operand2),
          *if node.operand2.is_a?(Model::Expressions::BinaryExpression) && (OPERATOR_PRECEDENCE[node.operand2.operator] > OPERATOR_PRECEDENCE[node.operator])
             ")"
           end,
        ].join("")
      end

      def format_expressions_entity_constructor(node)
        [
          format(node.entity),
          "(",
          node.parameters.map { |x| format(x) }.join(", "),
          ")",
        ].join("")
      end

      def format_expressions_function_call(node)
        [
          format(node.function),
          "(",
          node.parameters.map { |x| format(x) }.join(", "),
          ")",
        ].join("")
      end

      def format_expressions_interval(node)
        [
          "{",
          format(node.low),
          " ",
          case node.operator1
          when Model::Expressions::Interval::LESS_THAN then "<"
          when Model::Expressions::Interval::LESS_THAN_OR_EQUAL then "<="
          end,
          " ",
          format(node.item),
          " ",
          case node.operator2
          when Model::Expressions::Interval::LESS_THAN then "<"
          when Model::Expressions::Interval::LESS_THAN_OR_EQUAL then "<="
          end,
          " ",
          format(node.high),
          "}",
        ].join("")
      end

      def format_expressions_query_expression(node)
        [
          "QUERY",
          "(",
          node.id,
          " ",
          "<*",
          " ",
          format(node.aggregate_source),
          " ",
          "|",
          " ",
          format(node.expression),
          *format_remarks(node).instance_eval { |x| x.length.positive? ? ["\n", *x, "\n"] : x },
          ")",
        ].join("")
      end

      def format_expressions_unary_expression(node)
        [
          case node.operator
          when Model::Expressions::UnaryExpression::MINUS then "-"
          when Model::Expressions::UnaryExpression::NOT then "NOT"
          when Model::Expressions::UnaryExpression::PLUS then "+"
          end,
          if node.operator == Model::Expressions::UnaryExpression::NOT
            " "
          end,
          *if node.operand.is_a? Model::Expressions::BinaryExpression
             "("
           end,
          format(node.operand),
          *if node.operand.is_a? Model::Expressions::BinaryExpression
             ")"
           end,
        ].join("")
      end

      def format_literals_binary(node)
        [
          "%",
          node.value,
        ].join("")
      end

      def format_literals_integer(node)
        node.value
      end

      def format_literals_logical(node)
        case node.value
        when Model::Literals::Logical::TRUE then "TRUE"
        when Model::Literals::Logical::FALSE then "FALSE"
        when Model::Literals::Logical::UNKNOWN then "UNKNOWN"
        end
      end

      def format_literals_real(node)
        node.value
      end

      def format_literals_string(node)
        if node.encoded
          [
            "\"",
            node.value,
            "\"",
          ].join("")
        else
          [
            "'",
            node.value,
            "'",
          ].join("")
        end
      end

      def format_references_attribute_reference(node)
        [
          format(node.ref),
          ".",
          format(node.attribute),
        ].join("")
      end

      def format_references_group_reference(node)
        [
          format(node.ref),
          "\\",
          format(node.entity),
        ].join("")
      end

      def format_references_index_reference(node)
        [
          format(node.ref),
          "[",
          format(node.index1),
          *if node.index2
             [
               ":",
               format(node.index2),
             ].join("")
           end,
          "]",
        ].join("")
      end

      def format_references_simple_reference(node)
        node.id
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
          ].join(""),
          *if node.statements.length.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          *format_remarks(node),
          [
            "END_ALIAS",
            ";",
          ].join(""),
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
        ].join("")
      end

      def format_statements_procedure_call(node)
        [
          format(node.procedure),
          *if node.parameters.length.positive?
             [
               "(",
               node.parameters.map { |x| format(x) }.join(", "),
               ")",
             ].join("")
           end,
          ";",
        ].join("")
      end

      def format_statements_case(node)
        [
          [
            "CASE",
            " ",
            format(node.expression),
            " ",
            "OF",
          ].join(""),
          *if node.actions.length.positive?
             node.actions.map { |x| format(x) }
           end,
          *if node.otherwise_statement
             [
               [
                 "OTHERWISE",
                 " ",
                 ":",
               ].join(""),
               indent(format(node.otherwise_statement)),
             ]
           end,
          [
            "END_CASE",
            ";",
          ].join(""),
        ].join("\n")
      end

      def format_statements_case_action(node)
        [
          [
            node.labels.map { |x| format(x) }.join(", "),
            " ",
            ":",
          ].join(""),
          indent(format(node.statement)),
        ].join("\n")
      end

      def format_statements_compound(node)
        [
          "BEGIN",
          *if node.statements.length.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          [
            "END",
            ";",
          ].join(""),
        ].join("\n")
      end

      def format_statements_escape(_node)
        [
          "ESCAPE",
          ";",
        ].join("")
      end

      def format_statements_if(node)
        [
          [
            "IF",
            " ",
            format(node.expression),
            " ",
            "THEN",
          ].join(""),
          *if node.statements.length.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          *if node.else_statements.length.positive?
             [
               "ELSE",
               indent(node.else_statements.map { |x| format(x) }.join("\n")),
             ].join("\n")
           end,
          [
            "END_IF",
            ";",
          ].join(""),
        ].join("\n")
      end

      def format_statements_null(_node)
        ";"
      end

      def format_statements_repeat(node)
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
                    ].join("")
                  end,
               ].join("")
             end,
            *if node.while_expression
               [
                 " ",
                 "WHILE",
                 " ",
                 format(node.while_expression),
               ].join("")
             end,
            *if node.until_expression
               [
                 " ",
                 "UNTIL",
                 " ",
                 format(node.until_expression),
               ].join("")
             end,
            ";",
          ].join(""),
          *if node.statements.length.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          *format_remarks(node),
          [
            "END_REPEAT",
            ";",
          ].join(""),
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
             ].join("")
           end,
          ";",
        ].join("")
      end

      def format_statements_skip(_node)
        [
          "SKIP",
          ";",
        ].join("")
      end

      def format_supertype_expressions_binary_supertype_expression(node)
        [
          *if node.operand1.is_a?(Model::SupertypeExpressions::BinarySupertypeExpression) && (SUPERTYPE_OPERATOR_PRECEDENCE[node.operand1.operator] > SUPERTYPE_OPERATOR_PRECEDENCE[node.operator])
             "("
           end,
          format(node.operand1),
          *if node.operand1.is_a?(Model::SupertypeExpressions::BinarySupertypeExpression) && (SUPERTYPE_OPERATOR_PRECEDENCE[node.operand1.operator] > SUPERTYPE_OPERATOR_PRECEDENCE[node.operator])
             ")"
           end,
          " ",
          case node.operator
          when Model::SupertypeExpressions::BinarySupertypeExpression::AND then "AND"
          when Model::SupertypeExpressions::BinarySupertypeExpression::ANDOR then "ANDOR"
          end,
          " ",
          *if node.operand2.is_a?(Model::SupertypeExpressions::BinarySupertypeExpression) && (SUPERTYPE_OPERATOR_PRECEDENCE[node.operand2.operator] > SUPERTYPE_OPERATOR_PRECEDENCE[node.operator])
             "("
           end,
          format(node.operand2),
          *if node.operand2.is_a?(Model::SupertypeExpressions::BinarySupertypeExpression) && (SUPERTYPE_OPERATOR_PRECEDENCE[node.operand2.operator] > SUPERTYPE_OPERATOR_PRECEDENCE[node.operator])
             ")"
           end,
        ].join("")
      end

      def format_supertype_expressions_oneof_supertype_expression(node)
        [
          "ONEOF",
          "(",
          node.operands.map { |x| format(x) }.join(", "),
          ")",
        ].join("")
      end

      def format_data_types_aggregate(_node)
        "AGGREGATE"
      end

      def format_data_types_array(node)
        [
          "ARRAY",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join("")
           end,
          " ",
          "OF",
          *if node.optional
             [
               " ",
               "OPTIONAL",
             ].join("")
           end,
          *if node.unique
             [
               " ",
               "UNIQUE",
             ].join("")
           end,
          " ",
          format(node.base_type),
        ].join("")
      end

      def format_data_types_bag(node)
        [
          "BAG",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join("")
           end,
          " ",
          "OF",
          " ",
          format(node.base_type),
        ].join("")
      end

      def format_data_types_binary(node)
        [
          "BINARY",
          *if node.width
             [
               " ",
               "(",
               format(node.width),
               ")",
             ].join("")
           end,
          *if node.fixed
             [
               " ",
               "FIXED",
             ].join("")
           end,
        ].join("")
      end

      def format_data_types_boolean(_node)
        "BOOLEAN"
      end

      def format_data_types_enumeration(node)
        [
          *if node.extensible
             [
               "EXTENSIBLE",
               " ",
             ].join("")
           end,
          "ENUMERATION",
          *if node.based_on
             [
               " ",
               "BASED_ON",
               " ",
               format(node.based_on),
               *if node.items.length.positive?
                  item_indent = INDENT_CHAR * "(".length
                  [
                    " ",
                    "WITH",
                    "\n",
                    indent([
                      "(",
                      node.items.map { |x| format(x) }.join(",\n#{item_indent}"),
                      ")",
                    ].join("")),
                  ].join("")
                end,
             ].join("")
           else
             [
               *if node.items.length.positive?
                  item_indent = INDENT_CHAR * "(".length
                  [
                    " ",
                    "OF",
                    "\n",
                    indent([
                      "(",
                      node.items.map { |x| format(x) }.join(",\n#{item_indent}"),
                      ")",
                    ].join("")),
                  ].join("")
                end,
             ].join("")
           end,
        ].join("")
      end

      def format_data_types_enumeration_item(node)
        node.id
      end

      def format_data_types_generic_entity(node)
        [
          "GENERIC_ENTITY",
          *if node.id
             [
               ":",
               node.id,
             ]
           end,
        ].join("")
      end

      def format_data_types_generic(node)
        [
          "GENERIC",
          *if node.id
             [
               ":",
               node.id,
             ]
           end,
        ].join("")
      end

      def format_data_types_integer(_node)
        "INTEGER"
      end

      def format_data_types_list(node)
        [
          "LIST",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join("")
           end,
          " ",
          "OF",
          *if node.unique
             [
               " ",
               "UNIQUE",
             ].join("")
           end,
          " ",
          format(node.base_type),
        ].join("")
      end

      def format_data_types_logical(_node)
        "LOGICAL"
      end

      def format_data_types_number(_node)
        "NUMBER"
      end

      def format_data_types_real(node)
        [
          "REAL",
          *if node.precision
             [
               " ",
               "(",
               format(node.precision),
               ")",
             ].join("")
           end,
        ].join("")
      end

      def format_data_types_select(node)
        [
          *if node.extensible
             [
               "EXTENSIBLE",
               " ",
             ].join("")
           end,
          *if node.generic_entity
             [
               "GENERIC_ENTITY",
               " ",
             ].join("")
           end,
          "SELECT",
          *if node.based_on
             [
               " ",
               "BASED_ON",
               " ",
               format(node.based_on),
               *if node.items.length.positive?
                  item_indent = INDENT_CHAR * "(".length
                  [
                    " ",
                    "WITH",
                    "\n",
                    indent([
                      "(",
                      node.items.map { |x| format(x) }.join(",\n#{item_indent}"),
                      ")",
                    ].join("")),
                  ].join("")
                end,
             ].join("")
           else
             [
               *if node.items.length.positive?
                  item_indent = INDENT_CHAR * "(".length
                  [
                    "\n",
                    indent([
                      "(",
                      node.items.map { |x| format(x) }.join(",\n#{item_indent}"),
                      ")",
                    ].join("")),
                  ].join("")
                end,
             ].join("")
           end,
        ].join("")
      end

      def format_data_types_set(node)
        [
          "SET",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join("")
           end,
          " ",
          "OF",
          " ",
          format(node.base_type),
        ].join("")
      end

      def format_data_types_string(node)
        [
          "STRING",
          *if node.width
             [
               " ",
               "(",
               format(node.width),
               ")",
             ].join("")
           end,
          *if node.fixed
             [
               " ",
               "FIXED",
             ].join("")
           end,
        ].join("")
      end

      def indent(str)
        str.split("\n").map { |x| "#{INDENT}#{x}" }.join("\n")
      end

      def format_remark(node, remark)
        if remark.include?("\n")
          [
            [
              "(*",
              '"',
              node.path || node.id,
              '"',
            ].join(""),
            remark,
            "*)",
          ].join("\n")
        else
          [
            "--",
            '"',
            node.path || node.id,
            '"',
            " ",
            remark,
          ].join("")
        end
      end

      def format_remarks(node)
        if node.class.method_defined? :remarks
          node.remarks.map do |remark|
            format_remark(node, remark)
          end
        else
          []
        end
      end

      def format_scope_remarks(node)
        [
          *format_remarks(node),
          *node.children.select do |x|
            !x.is_a? Model::DataTypes::EnumerationItem or node.is_a? Model::Declarations::Type
          end.flat_map { |x| format_scope_remarks(x) },
        ]
      end
    end
  end
end
