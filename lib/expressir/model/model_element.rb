require 'pathname'

module Expressir
  module Model
    class ModelElement
      CLASS_KEY = '_class'
      FILE_KEY = 'file'
      SOURCE_KEY = 'source'

      attr_accessor :parent

      def initialize(options = {})
        attach_parent_to_children
      end

      def path
        # this creates an implicit scope
        return if is_a? Statements::Alias or is_a? Statements::Repeat or is_a? Expressions::QueryExpression

        current_node = self
        path_parts = []
        loop do
          if current_node.class.method_defined? :id and !(current_node.is_a? Expressions::SimpleReference)
            path_parts << current_node.id
          end

          current_node = current_node.parent
          break unless current_node
        end

        return if path_parts.empty?

        path_parts.reverse.join(".")
      end

      def attach_parent_to_children

        self.class.model_attrs.each do |variable|
          value = self.send(variable)

          if value.is_a? Array
            value.each do |value|
              if value.is_a? ModelElement
                value.parent = self
              end
            end
          elsif value.is_a? ModelElement
            value.parent = self
          end
        end
      end

      def find(path)
        return self if path.empty?

        path_parts = path.downcase.split(/\./).map do |current_path|
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

        if target_node.is_a? Model::InterfacedItem
          target_node = target_node.base_item
        end

        target_node
      end

      def children
        []
      end

      def children_by_id
        @children_by_id ||= children.select{|x| x.id}.map{|x| [x.id.downcase, x]}.to_h
      end

      def reset_children_by_id
        @children_by_id = nil
      end

      def to_hash(options = {})
        root_path = options[:root_path]
        formatter = options[:formatter]
        include_empty = options[:include_empty] || !options[:skip_empty] # TODO: remove skip_empty

        hash = {}
        hash[CLASS_KEY] = self.class.name

        self.class.model_attrs.each do |variable|
          value = self.send(variable)
          empty = value.nil? || (value.is_a?(Array) && value.count == 0)

          # skip empty values
          if !empty or include_empty
            hash[variable.to_s] = if value.is_a? Array
              value.map do |value|
                if value.is_a? ModelElement
                  value.to_hash(options)
                else
                  value
                end
              end
            elsif value.is_a? ModelElement
              value.to_hash(options)
            else
              value
            end
          end
        end

        if self.is_a? Schema and file
          hash[FILE_KEY] = root_path ? Pathname.new(file).relative_path_from(root_path).to_s : file
        end

        if self.class.method_defined? :source and formatter
          hash[SOURCE_KEY] = formatter.format(self)
        end

        hash
      end

      def self.from_hash(hash, options = {})
        root_path = options[:root_path]

        node_class = Object.const_get(hash[CLASS_KEY])
        node_options = {}

        node_class.model_attrs.each do |variable|
          value = hash[variable.to_s]

          node_options[variable] = if value.is_a? Array
            value.map do |value|
              if value.is_a? Hash
                self.from_hash(value, options)
              else
                value
              end
            end
          elsif value.is_a? Hash
            self.from_hash(value, options)
          else
            value
          end
        end

        if node_class == Schema and hash[FILE_KEY]
          node_options[FILE_KEY.to_sym] = root_path ? File.expand_path("#{root_path}/#{hash[FILE_KEY]}") : hash[FILE_KEY]
        end

        node = node_class.new(node_options)

        node
      end

      def self.model_attrs
        @model_attrs ||= []
      end

      def self.model_attr_accessor(*vars)
        @model_attrs ||= []
        @model_attrs.concat(vars)

        attr_accessor *vars
      end
    end
  end
end