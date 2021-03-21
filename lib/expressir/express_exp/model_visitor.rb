require "expressir/model"

module Expressir
  module ExpressExp
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