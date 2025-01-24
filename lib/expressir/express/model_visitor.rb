require_relative "../model"

module Expressir
  module Express
    # @abstract
    class ModelVisitor
      def visit(node)
        node.class.model_attrs.each do |variable|
          value = node.send(variable)

          if value.is_a? Array
            value.each do |value|
              if value.is_a? Model::ModelElement
                visit(value)
              end
            end
          elsif value.is_a? Model::ModelElement
            visit(value)
          end
        end
      end
    end
  end
end
