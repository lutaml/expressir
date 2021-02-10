module Expressir
  module Model
    class ModelElement
      CLASS_KEY = '_class'
      SOURCE_KEY = 'source'

      attr_accessor :parent

      def initialize(options = {})
        attach_parent_to_children
      end

      def path
        return id if is_a? Statements::Alias or is_a? Statements::Repeat or is_a? Expressions::QueryExpression

        current_node = self
        path_parts = []
        loop do
          if current_node.class.method_defined? :id
            path_parts << current_node.id
          end

          current_node = current_node.parent
          break unless current_node
        end

        path_parts.reverse.join(".")
      end

      def attach_parent_to_children
        instance_variables.select{|x| x != :@parent}.each do |variable|
          value = instance_variable_get(variable)

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
            current_node = current_node.children.find{|x| x.id and x.id.downcase == current_path}
            break unless current_node
          end
          target_node = current_node
          break if target_node

          # retry search in parent scope
          current_scope = current_scope.parent
          break unless current_scope
        end

        target_node
      end

      def children
        []
      end

      def to_hash(options = {})
        skip_empty = options[:skip_empty]
        formatter = options[:formatter]

        hash = {}
        hash[CLASS_KEY] = self.class.name

        instance_variables.select{|x| x != :@parent}.each_with_object(hash) do |variable, result|
          key = variable.to_s.sub(/^@/, '')
          value = instance_variable_get(variable)

          # skip empty values (nil, empty array)
          if !skip_empty or !(value.nil? or (value.is_a? Array and value.count == 0))
            result[key] = if value.is_a? Array
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

        if formatter
          hash[SOURCE_KEY] = formatter.format(self)
        end

        hash
      end

      def self.from_hash(hash)
        node_class = hash[CLASS_KEY]
        node_options = hash.select{|x| x != CLASS_KEY}.each_with_object({}) do |(variable, value), result|
          key = variable.to_sym

          result[key] = if value.is_a? Array
            value.map do |value|
              if value.is_a? Hash
                self.from_hash(value)
              else
                value
              end
            end
          elsif value.is_a? Hash
            self.from_hash(value)
          else
            value
          end
        end

        node = Object.const_get(node_class).new(node_options)

        node
      end
    end
  end
end