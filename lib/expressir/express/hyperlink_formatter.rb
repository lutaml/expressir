module Expressir
  module Express
    # Formatter module - format references as hyperlinks
    # @example Include into Formatter subclass
    #   formatter = Class.new(Expressir::Express::Formatter) do
    #     include Expressir::Express::HyperlinkFormatter
    #   end
    module HyperlinkFormatter
      # @!visibility private
      def self.included(mod)
        unless mod.superclass <= Expressir::Express::Formatter
          raise Error::FormatterMethodMissingError.new("HyperlinkFormatter",
                                                       "format_references_simple_reference")
        end
      end

      def format_references_simple_reference(node)
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

        # The anchor namespace keys on schema.item, not on the
        # file-prefixed path: the file rides the filesystem path as
        # its id (model/exp_file), so base_path carries
        # `<path>.exp.schema.item` and the link must shed the file
        # part (#786) — otherwise no listing link finds its target on
        # the document pages. Strip up to the LAST `.exp.` boundary
        # (the greedy form WG 12's templates apply as a workaround),
        # which also covers nested items (`schema.entity.attr`) and
        # absolute paths.
        exp_boundary = node_base_path_parts.rindex("exp")
        anchor = if exp_boundary
                   node_base_path_parts[(exp_boundary + 1)..].join(".")
                 else
                   node.base_path
                 end

        "{{{<<express:#{anchor},#{node.id}>>}}}"
      end
    end
  end
end
