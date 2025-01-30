require "pathname"

module Expressir
  module Model
    # Base model element
    class ModelElement
      CLASS_KEY = "_class".freeze
      FILE_KEY = "file".freeze
      SOURCE_KEY = "source".freeze

      private_constant :CLASS_KEY
      private_constant :FILE_KEY
      private_constant :SOURCE_KEY

      # @return [ModelElement]
      attr_accessor :parent

      # @param [Hash] options
      def initialize(_options = {})
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

      # @param [String] root_path
      # @param [Express::Formatter] formatter
      # @param [Boolean] include_empty
      # @param [Proc] select_proc
      # @return [Hash]
      def to_hash(root_path: nil, formatter: nil, include_empty: nil, select_proc: nil)
        # Filter out entries
        has_filter = !select_proc.nil? && select_proc.is_a?(Proc)
        return nil if has_filter && !select_proc.call(self)

        hash = {}
        hash[CLASS_KEY] = self.class.name

        self.class.model_attrs.each do |variable|
          value = send(variable)
          empty = value.nil? || (value.is_a?(Array) && value.count.zero?)

          # skip empty values
          next unless !empty || include_empty

          value_hash = case value
                       when Array
                         value.map do |v|
                           if v.is_a? ModelElement
                             v.to_hash(
                               root_path: root_path,
                               formatter: formatter,
                               include_empty: include_empty,
                               select_proc: select_proc,
                             )
                           else
                             v
                           end
                         end.compact
                       when ModelElement
                         value.to_hash(
                           root_path: root_path,
                           formatter: formatter,
                           include_empty: include_empty,
                           select_proc: select_proc,
                         )
                       else
                         value
                       end

          hash[variable.to_s] = value_hash unless value_hash.nil?
        end

        if is_a?(Declarations::Schema) && file
          hash[FILE_KEY] = root_path ? Pathname.new(file).relative_path_from(root_path).to_s : file
        end

        if self.class.method_defined?(:source) && formatter
          hash[SOURCE_KEY] = formatter.format(self)
        end

        hash
      end

      # @return [Liquid::Drop]
      def to_liquid(selected_schemas: nil, options: nil)
        klass_name = "#{self.class.name.gsub('::Model::', '::Liquid::')}Drop"
        klass = Object.const_get(klass_name)
        klass.new(self, selected_schemas: selected_schemas, options: options)
      end

      def to_s(no_remarks: false, formatter: nil)
        f = formatter || Express::Formatter.new(no_remarks: no_remarks)
        f.no_remarks = no_remarks
        f.format(self)
      end

      # @param [Hash] hash
      # @param [String] root_path
      # @return [ModelElement]
      def self.from_hash(hash, root_path: nil)
        node_class = Object.const_get(hash[CLASS_KEY])
        node_options = {}

        node_class.model_attrs.each do |variable|
          value = hash[variable.to_s]

          node_options[variable] = case value
                                   when Array
                                     value.map do |value|
                                       if value.is_a? Hash
                                         from_hash(value, root_path: root_path)
                                       else
                                         value
                                       end
                                     end
                                   when Hash
                                     from_hash(value, root_path: root_path)
                                   else
                                     value
                                   end
        end

        if (node_class == Declarations::Schema) && hash[FILE_KEY]
          node_options[FILE_KEY.to_sym] = root_path ? File.expand_path("#{root_path}/#{hash[FILE_KEY]}") : hash[FILE_KEY]
        end

        node_class.new(node_options)
      end

      # @return [Array<Symbol>]
      def self.model_attrs
        @model_attrs ||= []
      end

      # Define a new model attribute
      # @param attr_name [Symbol] attribute name
      # @param attr_type [Symbol] attribute type
      # @!macro [attach] model_attr_accessor
      #   @!attribute $1
      #     @return [$2]
      def self.model_attr_accessor(attr_name, _attr_type = nil)
        @model_attrs ||= []
        @model_attrs << attr_name

        attr_accessor attr_name
      end

      private

      # @return [nil]
      def attach_parent_to_children
        self.class.model_attrs.each do |variable|
          value = send(variable)

          case value
          when Array
            value.each do |value|
              if value.is_a? ModelElement
                value.parent = self
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
