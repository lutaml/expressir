require "expressir/express_exp/model_visitor"
require "expressir/model"

module Expressir
  module ExpressExp
    class ResolveReferencesModelVisitor < ModelVisitor
      def visit(node)
        if node.is_a? Model::Expressions::SimpleReference
          visit_expressions_simple_reference(node)
        end

        super
      end

      def visit_expressions_simple_reference(node)
        return if node.parent.is_a? Model::Expressions::AttributeReference

        if node.parent.is_a? Model::InterfaceItem
          base_item = node.find("#{node.parent.parent.schema.id}.#{node.parent.ref.id}")
        else
          base_item = node.find(node.id)
        end
        return unless base_item

        if base_item.is_a? Model::InterfacedItem
          base_item = base_item.base_item
        end

        node.base_path = base_item.path
      end
    end
  end
end