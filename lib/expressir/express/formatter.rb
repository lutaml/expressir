require_relative "formatters/remark_item_formatter"
require_relative "formatters/remark_formatter"
require_relative "formatters/literals_formatter"
require_relative "formatters/references_formatter"
require_relative "formatters/supertype_expressions_formatter"
require_relative "formatters/statements_formatter"
require_relative "formatters/expressions_formatter"
require_relative "formatters/data_types_formatter"
require_relative "formatters/declarations_formatter"

module Expressir
  module Express
    class Formatter
      include RemarkItemFormatter
      include RemarkFormatter
      include LiteralsFormatter
      include ReferencesFormatter
      include SupertypeExpressionsFormatter
      include StatementsFormatter
      include ExpressionsFormatter
      include DataTypesFormatter
      include DeclarationsFormatter

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

      attr_accessor :no_remarks

      def initialize(no_remarks: false)
        @no_remarks = no_remarks
      end

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
      def format(node) # rubocop:disable Metrics/MethodLength
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
        when Model::Declarations::InformalPropositionRule
          format_declarations_informal_proposition_rule(node)
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
        when Model::Declarations::SchemaVersionItem
          # not implemented yet
        when Model::Declarations::InterfacedItem
          # not implemented yet
        when Model::Declarations::RemarkItem
          format_remark_item(node)
        when Model::Cache
          # not implemented yet
        when Model::ModelElement
          # not implemented yet
        when NilClass
          # not implemented yet
        else
          warn "#{node.class.name} format not implemented"
          ""
        end
      end

      private

      def format_repository(node)
        result = node.schemas&.map { |x| format(x) }&.join("\n\n")
        result ? "#{result}\n" : ""
      end

      def indent(str)
        return if str.nil?

        str.split("\n").map { |x| "#{INDENT}#{x}" }.join("\n")
      end
    end
  end
end
