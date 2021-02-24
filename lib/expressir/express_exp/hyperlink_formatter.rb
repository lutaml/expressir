require "expressir/express_exp/formatter"

module Expressir
  module ExpressExp
    class HyperlinkFormatter < Formatter
      def format_expressions_simple_reference(node)
        return node.id if node.parent.is_a? Model::Expressions::AttributeReference

        # skip hyperlink if target node can't be found
        target_node = node.find(node.id)
        return node.id unless target_node

        # skip hyperlink for implicit scopes
        return node.id if target_node.is_a? Model::Statements::Alias or target_node.is_a? Model::Statements::Repeat or target_node.is_a? Model::Expressions::QueryExpression

        # skip hyperlink if this node and target node are in the same main item
        node_path_parts = node.path.split(".")
        target_node_path_parts = target_node.path.split(".")
        return node.id if node_path_parts[0..1] == target_node_path_parts[0..1]

        "{{{<<express:#{target_node.path},#{node.id}>>}}}"
      end
    end
  end
end