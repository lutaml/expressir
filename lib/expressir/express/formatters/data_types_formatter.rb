module Expressir
  module Express
    module DataTypesFormatter
      private

      def format_data_types_aggregate(_node)
        "AGGREGATE"
      end

      def format_data_types_array(node)
        [
          "ARRAY",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join
           end,
          " ",
          "OF",
          *if node.optional
             [
               " ",
               "OPTIONAL",
             ].join
           end,
          *if node.unique
             [
               " ",
               "UNIQUE",
             ].join
           end,
          " ",
          format(node.base_type),
        ].join
      end

      def format_data_types_bag(node)
        [
          "BAG",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join
           end,
          " ",
          "OF",
          " ",
          format(node.base_type),
        ].join
      end

      def format_data_types_binary(node)
        [
          "BINARY",
          *if node.width
             [
               " ",
               "(",
               format(node.width),
               ")",
             ].join
           end,
          *if node.fixed
             [
               " ",
               "FIXED",
             ].join
           end,
        ].join
      end

      def format_data_types_boolean(_node)
        "BOOLEAN"
      end

      def format_data_types_enumeration(node)
        indent_char = self.class.const_get(:INDENT_CHAR)
        [
          *if node.extensible
             [
               "EXTENSIBLE",
               " ",
             ].join
           end,
          "ENUMERATION",
          *if node.based_on
             [
               " ",
               "BASED_ON",
               " ",
               format(node.based_on),
               *if node.items&.length&.positive?
                  item_indent = indent_char * "(".length
                  [
                    " ",
                    "WITH",
                    "\n",
                    indent([
                      "(",
                      node.items.map do |x|
                        format(x)
                      end.join(",\n#{item_indent}"),
                      ")",
                    ].join),
                  ].join
                end,
             ].join
           else
             [
               *if node.items&.length&.positive?
                  item_indent = indent_char * "(".length
                  [
                    " ",
                    "OF",
                    "\n",
                    indent([
                      "(",
                      node.items.map do |x|
                        format(x)
                      end.join(",\n#{item_indent}"),
                      ")",
                    ].join),
                  ].join
                end,
             ].join
           end,
        ].join
      end

      def format_data_types_enumeration_item(node)
        node.id
      end

      def format_data_types_generic_entity(node)
        [
          "GENERIC_ENTITY",
          *if node.id
             [
               ":",
               node.id,
             ]
           end,
        ].join
      end

      def format_data_types_generic(node)
        [
          "GENERIC",
          *if node.id
             [
               ":",
               node.id,
             ]
           end,
        ].join
      end

      def format_data_types_integer(_node)
        "INTEGER"
      end

      def format_data_types_list(node)
        [
          "LIST",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join
           end,
          " ",
          "OF",
          *if node.unique
             [
               " ",
               "UNIQUE",
             ].join
           end,
          " ",
          format(node.base_type),
        ].join
      end

      def format_data_types_logical(_node)
        "LOGICAL"
      end

      def format_data_types_number(_node)
        "NUMBER"
      end

      def format_data_types_real(node)
        [
          "REAL",
          *if node.precision
             [
               " ",
               "(",
               format(node.precision),
               ")",
             ].join
           end,
        ].join
      end

      def format_data_types_select(node)
        indent_char = self.class.const_get(:INDENT_CHAR)
        node.items ||= []
        [
          *if node.extensible
             [
               "EXTENSIBLE",
               " ",
             ].join
           end,
          *if node.generic_entity
             [
               "GENERIC_ENTITY",
               " ",
             ].join
           end,
          "SELECT",
          *if node.based_on
             [
               " ",
               "BASED_ON",
               " ",
               format(node.based_on),
               *if node.items&.length&.positive?
                  item_indent = indent_char * "(".length
                  [
                    " ",
                    "WITH",
                    "\n",
                    indent([
                      "(",
                      node.items.map do |x|
                        format(x)
                      end.join(",\n#{item_indent}"),
                      ")",
                    ].join),
                  ].join
                end,
             ].join
           else
             double_indent = indent(indent(""))
             item_indent = double_indent.length
             [
               "\n",
               indent("OF"),
               "\n",
               indent(indent([
                 "(",
                 node.items.map do |x|
                   format(x)
                 end.join(",\n#{indent_char * item_indent}"),
                 ")",
               ].join)),
             ].join
           end,
        ].join
      end

      def format_data_types_set(node)
        [
          "SET",
          *if node.bound1 && node.bound2
             [
               " ",
               "[",
               format(node.bound1),
               ":",
               format(node.bound2),
               "]",
             ].join
           end,
          " ",
          "OF",
          " ",
          format(node.base_type),
        ].join
      end

      def format_data_types_string(node)
        [
          "STRING",
          *if node.width
             [
               " ",
               "(",
               format(node.width),
               ")",
             ].join
           end,
          *if node.fixed
             [
               " ",
               "FIXED",
             ].join
           end,
        ].join
      end
    end
  end
end