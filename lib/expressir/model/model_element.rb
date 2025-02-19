require "pathname"

module Expressir
  module Model
    # Base model element
    class ModelElement < Lutaml::Model::Serializable
      SKIP_ATTRIBUTES = %i[parent _class].freeze
      # :parent is a special attribute that is used to store the parent of the current element
      # It is not a real attribute
      attribute :parent, ModelElement
      attribute :source, :string
      attribute :_class, :string, default: -> { self.send(:name) }
      attribute :source, :string

      # TODO: Add basic mappings that can be inherited by all subclasses
      key_value do
        map "_class", to: :_class, render_default: true
        map "source", to: :source
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

        path_parts = path.safe_downcase.split(/\./).map do |current_path|
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
        self.class.attributes.each_pair do |symbol, lutaml_attr|
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
