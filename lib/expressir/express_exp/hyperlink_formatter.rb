module Expressir
  module ExpressExp
    module HyperlinkFormatter
      def format_expressions_simple_reference(node)
        return node.id unless node.base_path

        # find closest node with path
        current_node = node
        while !current_node.path
          current_node = current_node.parent
        end

        # skip if this reference and target node are in the same node with path
        node_base_path_parts = node.base_path.split(".")
        current_node_path_parts = current_node.path.split(".")
        return node.id if node_base_path_parts[0..1] == current_node_path_parts[0..1]

        "{{{<<express:#{node.base_path},#{node.id}>>}}}"
      end
    end
  end
end