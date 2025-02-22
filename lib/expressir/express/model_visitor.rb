module Expressir
  module Express
    # @abstract
    class ModelVisitor
      def visit(node)
        node.class.attributes.each do |symbol, lutaml_attr|
          next if ::Expressir::Model::ModelElement::SKIP_ATTRIBUTES.include?(symbol)

          value = node.send(symbol)

          case value
          when Array
            value.each do |val|
              if val.is_a? Model::ModelElement
                visit(val)
              end
            end
          when Model::ModelElement
            visit(value)
          end
        end
      end
    end
  end
end
