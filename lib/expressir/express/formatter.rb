module Expressir
  module Express
    class Formatter
      # Registry infrastructure — must precede includes so modules can register handlers
      @format_registry = {}

      def self.format_registry
        @format_registry || superclass&.format_registry
      end

      def self.register_formatter(model_class, method_name)
        # Guard: fail at registration time if the method doesn't exist on
        # this class (or one of its included modules). Includes private
        # methods since format handlers are private (TODO.bugs/19).
        unless method_defined?(method_name) || private_method_defined?(method_name)
          raise ArgumentError,
                "Formatter.register_formatter: method :#{method_name} " \
                "is not defined for #{model_class}"
        end

        @format_registry[model_class] = method_name
      end

      # Include formatter modules — each registers its handlers via self.included
      include Formatters::RemarkItemFormatter
      include Formatters::RemarkFormatter
      include Formatters::LiteralsFormatter
      include Formatters::ReferencesFormatter
      include Formatters::SupertypeExpressionsFormatter
      include Formatters::StatementsFormatter
      include Formatters::ExpressionsFormatter
      include Formatters::DataTypesFormatter
      include Formatters::DeclarationsFormatter

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

      attr_accessor :no_remarks

      def initialize(no_remarks: false)
        @no_remarks = no_remarks
      end

      def self.format(node)
        new.format(node)
      end

      def format(node)
        return "" if node.nil?

        handler = self.class.format_registry[node.class]
        return send(handler, node) if handler

        warn "#{node.class.name} format not implemented"
        ""
      end

      private

      def format_noop(_node)
        ""
      end

      def format_repository(node)
        result = node.files&.map { |f| format(f) }&.join("\n\n")
        result ? "#{result}\n" : ""
      end

      def format_exp_file(node)
        result = node.schemas&.map { |x| format(x) }&.join("\n\n")
        result ? "#{result}\n" : ""
      end

      def indent(str)
        return if str.nil?

        str.split("\n").map { |x| "#{INDENT}#{x}" }.join("\n")
      end

      # Handlers for types implemented directly in this class.
      # Registered at the bottom so the methods exist when the
      # registration-time method_defined? guard runs.
      register_formatter Model::Repository, :format_repository
      register_formatter Model::ExpFile, :format_exp_file
      register_formatter Model::Declarations::SchemaVersionItem, :format_noop
      register_formatter Model::Declarations::InterfacedItem, :format_noop
      register_formatter Model::Cache, :format_noop
      register_formatter Model::ModelElement, :format_noop
    end
  end
end
