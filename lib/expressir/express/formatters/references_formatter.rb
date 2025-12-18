module Expressir
  module Express
    module ReferencesFormatter
      private

      def format_references_attribute_reference(node)
        [
          format(node.ref),
          ".",
          format(node.attribute),
        ].join
      end

      def format_references_group_reference(node)
        [
          format(node.ref),
          "\\",
          format(node.entity),
        ].join
      end

      def format_references_index_reference(node)
        [
          format(node.ref),
          "[",
          format(node.index1),
          *if node.index2
             [
               ":",
               format(node.index2),
             ].join
           end,
          "]",
        ].join
      end

      def format_references_simple_reference(node)
        node.id
      end
    end
  end
end