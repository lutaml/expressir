require "pathname"

module Expressir
  module Model
    # Base model element
    class ModelElement < Lutaml::Model::Serializable
      SKIP_ATTRIBUTES = %i[parent _class].freeze
      ATTACH_SKIP_ATTRIBUTES = Set.new(
        %i[parent _class source id remarks
                 remark_items base_path operator value
                 operator1 operator2 name]).freeze
      # :parent is a special attribute that is used to store the parent of the current element
      # It is not a real attribute
      # attribute :parent, ModelElement
      attr_accessor :parent

      attribute :_class, :string, default: -> { send(:name) },
                                  polymorphic_class: true
      attribute :source, :string

      # TODO: Add basic mappings that can be inherited by all subclasses
      key_value do
        map "_class", to: :_class, render_default: true,
                      polymorphic_map: {
                        "Expressir::Model::Cache" =>
                        "Expressir::Model::Cache",
                        "Expressir::Model::Repository" =>
            "Expressir::Model::Repository",
                        "Expressir::Model::DataTypes::Aggregate" =>
            "Expressir::Model::DataTypes::Aggregate",
                        "Expressir::Model::DataTypes::Array" =>
            "Expressir::Model::DataTypes::Array",
                        "Expressir::Model::DataTypes::Bag" =>
            "Expressir::Model::DataTypes::Bag",
                        "Expressir::Model::DataTypes::Binary" =>
            "Expressir::Model::DataTypes::Binary",
                        "Expressir::Model::DataTypes::Boolean" =>
            "Expressir::Model::DataTypes::Boolean",
                        "Expressir::Model::DataTypes::EnumerationItem" =>
            "Expressir::Model::DataTypes::EnumerationItem",
                        "Expressir::Model::DataTypes::Enumeration" =>
            "Expressir::Model::DataTypes::Enumeration",
                        "Expressir::Model::DataTypes::GenericEntity" =>
            "Expressir::Model::DataTypes::GenericEntity",
                        "Expressir::Model::DataTypes::Generic" =>
            "Expressir::Model::DataTypes::Generic",
                        "Expressir::Model::DataTypes::Integer" =>
            "Expressir::Model::DataTypes::Integer",
                        "Expressir::Model::DataTypes::List" =>
            "Expressir::Model::DataTypes::List",
                        "Expressir::Model::DataTypes::Logical" =>
            "Expressir::Model::DataTypes::Logical",
                        "Expressir::Model::DataTypes::Number" =>
            "Expressir::Model::DataTypes::Number",
                        "Expressir::Model::DataTypes::Real" =>
            "Expressir::Model::DataTypes::Real",
                        "Expressir::Model::DataTypes::Select" =>
            "Expressir::Model::DataTypes::Select",
                        "Expressir::Model::DataTypes::Set" =>
            "Expressir::Model::DataTypes::Set",
                        "Expressir::Model::DataTypes::String" =>
            "Expressir::Model::DataTypes::String",
                        "Expressir::Model::Declarations::Attribute" =>
            "Expressir::Model::Declarations::Attribute",
                        "Expressir::Model::Declarations::Constant" =>
            "Expressir::Model::Declarations::Constant",
                        "Expressir::Model::Declarations::Entity" =>
            "Expressir::Model::Declarations::Entity",
                        "Expressir::Model::Declarations::Function" =>
            "Expressir::Model::Declarations::Function",
                        "Expressir::Model::Declarations::InterfaceItem" =>
            "Expressir::Model::Declarations::InterfaceItem",
                        "Expressir::Model::Declarations::Interface" =>
            "Expressir::Model::Declarations::Interface",
                        "Expressir::Model::Declarations::InterfacedItem" =>
            "Expressir::Model::Declarations::InterfacedItem",
                        "Expressir::Model::Declarations::Parameter" =>
            "Expressir::Model::Declarations::Parameter",
                        "Expressir::Model::Declarations::Procedure" =>
            "Expressir::Model::Declarations::Procedure",
                        "Expressir::Model::Declarations::RemarkItem" =>
            "Expressir::Model::Declarations::RemarkItem",
                        "Expressir::Model::Declarations::Rule" =>
            "Expressir::Model::Declarations::Rule",
                        "Expressir::Model::Declarations::SchemaVersionItem" =>
            "Expressir::Model::Declarations::SchemaVersionItem",
                        "Expressir::Model::Declarations::SchemaVersion" =>
            "Expressir::Model::Declarations::SchemaVersion",
                        "Expressir::Model::Declarations::Schema" =>
            "Expressir::Model::Declarations::Schema",
                        "Expressir::Model::Declarations::SubtypeConstraint" =>
            "Expressir::Model::Declarations::SubtypeConstraint",
                        "Expressir::Model::Declarations::Type" =>
            "Expressir::Model::Declarations::Type",
                        "Expressir::Model::Declarations::UniqueRule" =>
            "Expressir::Model::Declarations::UniqueRule",
                        "Expressir::Model::Declarations::Variable" =>
            "Expressir::Model::Declarations::Variable",
                        "Expressir::Model::Declarations::WhereRule" =>
            "Expressir::Model::Declarations::WhereRule",
                        "Expressir::Model::Expressions::AggregateInitializerItem" =>
            "Expressir::Model::Expressions::AggregateInitializerItem",
                        "Expressir::Model::Expressions::AggregateInitializer" =>
            "Expressir::Model::Expressions::AggregateInitializer",
                        "Expressir::Model::Expressions::BinaryExpression" =>
            "Expressir::Model::Expressions::BinaryExpression",
                        "Expressir::Model::Expressions::EntityConstructor" =>
            "Expressir::Model::Expressions::EntityConstructor",
                        "Expressir::Model::Expressions::FunctionCall" =>
            "Expressir::Model::Expressions::FunctionCall",
                        "Expressir::Model::Expressions::Interval" =>
            "Expressir::Model::Expressions::Interval",
                        "Expressir::Model::Expressions::QueryExpression" =>
            "Expressir::Model::Expressions::QueryExpression",
                        "Expressir::Model::Expressions::UnaryExpression" =>
            "Expressir::Model::Expressions::UnaryExpression",
                        "Expressir::Model::Literals::Binary" =>
            "Expressir::Model::Literals::Binary",
                        "Expressir::Model::Literals::Integer" =>
            "Expressir::Model::Literals::Integer",
                        "Expressir::Model::Literals::Logical" =>
            "Expressir::Model::Literals::Logical",
                        "Expressir::Model::Literals::Real" =>
            "Expressir::Model::Literals::Real",
                        "Expressir::Model::Literals::String" =>
            "Expressir::Model::Literals::String",
                        "Expressir::Model::References::AttributeReference" =>
            "Expressir::Model::References::AttributeReference",
                        "Expressir::Model::References::GroupReference" =>
            "Expressir::Model::References::GroupReference",
                        "Expressir::Model::References::IndexReference" =>
            "Expressir::Model::References::IndexReference",
                        "Expressir::Model::References::SimpleReference" =>
            "Expressir::Model::References::SimpleReference",
                        "Expressir::Model::Statements::Alias" =>
            "Expressir::Model::Statements::Alias",
                        "Expressir::Model::Statements::Assignment" =>
            "Expressir::Model::Statements::Assignment",
                        "Expressir::Model::Statements::CaseAction" =>
            "Expressir::Model::Statements::CaseAction",
                        "Expressir::Model::Statements::Case" =>
            "Expressir::Model::Statements::Case",
                        "Expressir::Model::Statements::Compound" =>
            "Expressir::Model::Statements::Compound",
                        "Expressir::Model::Statements::Escape" =>
            "Expressir::Model::Statements::Escape",
                        "Expressir::Model::Statements::If" =>
            "Expressir::Model::Statements::If",
                        "Expressir::Model::Statements::Null" =>
            "Expressir::Model::Statements::Null",
                        "Expressir::Model::Statements::ProcedureCall" =>
            "Expressir::Model::Statements::ProcedureCall",
                        "Expressir::Model::Statements::Repeat" =>
            "Expressir::Model::Statements::Repeat",
                        "Expressir::Model::Statements::Return" =>
            "Expressir::Model::Statements::Return",
                        "Expressir::Model::Statements::Skip" =>
            "Expressir::Model::Statements::Skip",
                        "Expressir::Model::SupertypeExpressions::BinarySupertypeExpression" =>
            "Expressir::Model::SupertypeExpressions::BinarySupertypeExpression",
                        "Expressir::Model::SupertypeExpressions::OneofSupertypeExpression" =>
            "Expressir::Model::SupertypeExpressions::OneofSupertypeExpression",
                      }
      end

      def source
        formatter = Class.new(Expressir::Express::Formatter) do
          include Expressir::Express::HyperlinkFormatter
        end
        formatter.format(self)
      end

      # @param [Hash] options
      def initialize(_options = {})
        super
        attach_parent_to_children
      end

      # @return [String]
      def path
        # this creates an implicit scope
        return if is_a?(Statements::Alias) || is_a?(Statements::Repeat) || is_a?(Expressions::QueryExpression)

        current_node = self
        path_parts = []
        loop do
          if current_node.class.method_defined?(:id) && !(current_node.is_a? References::SimpleReference)
            path_parts << current_node.id
          end

          current_node = current_node.parent
          break unless current_node
        end

        return if path_parts.empty?

        path_parts.reverse.join(".")
      end

      # @param [String] path
      # @return [ModelElement]
      def find(path)
        return self if path.empty?

        path_parts = path.safe_downcase.split(".").map do |current_path|
          _, _, current_path = current_path.rpartition(":") # ignore prefix
          current_path
        end

        current_scope = self
        target_node = nil
        loop do
          # find in current scope
          current_node = current_scope
          path_parts.each do |current_path|
            current_node = current_node.children_by_id[current_path]
            break unless current_node
          end
          target_node = current_node
          break if target_node

          # retry search in parent scope
          current_scope = current_scope.parent
          break unless current_scope
        end

        if target_node.is_a? Model::Declarations::InterfacedItem
          target_node = target_node.base_item
        end

        target_node
      end

      # @return [Array<Declaration>]
      def children
        []
      end

      # @return [Hash<String, Declaration>]
      def children_by_id
        @children_by_id ||= children.select(&:id).map { |x| [x.id.safe_downcase, x] }.to_h
      end

      # @return [nil]
      def reset_children_by_id
        @children_by_id = nil
        nil
      end

      def to_s(no_remarks: false, formatter: nil)
        f = formatter || Express::Formatter.new(no_remarks: no_remarks)
        f.no_remarks = no_remarks
        f.format(self)
      end

      private

      # @return [nil]
      def attach_parent_to_children
        self.class.attributes.each_pair do |symbol, _lutaml_attr|
          next if ATTACH_SKIP_ATTRIBUTES.include?(symbol)

          value = send(symbol)

          case value
          when Array
            value.each do |val|
              if val.is_a?(ModelElement)
                val.parent = self
              end
            end
          when ModelElement
            value.parent = self
          end
        end

        nil
      end
    end
  end
end
