module Expressir
  module Model
    class ModelElement
      CLASS_KEY = '_class' 

      def to_hash(options = {})
        skip_empty = options[:skip_empty]

        instance_variables.select{|x| x != :@parent}.each_with_object({ CLASS_KEY => self.class.name }) do |variable, result|
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

        if node.class.method_defined? :attach_parent_to_children
          node.attach_parent_to_children
        end

        node
      end
    end
  end
end