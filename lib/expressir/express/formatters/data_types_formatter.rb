module Expressir
  module Express
    module Formatters
      module DataTypesFormatter
        def self.included(base)
          base.register_formatter Model::DataTypes::Aggregate,
                                  :format_data_types_aggregate
          base.register_formatter Model::DataTypes::Array,
                                  :format_data_types_array
          base.register_formatter Model::DataTypes::Bag, :format_data_types_bag
          base.register_formatter Model::DataTypes::Binary,
                                  :format_data_types_binary
          base.register_formatter Model::DataTypes::Boolean,
                                  :format_data_types_boolean
          base.register_formatter Model::DataTypes::Enumeration,
                                  :format_data_types_enumeration
          base.register_formatter Model::DataTypes::EnumerationItem,
                                  :format_data_types_enumeration_item
          base.register_formatter Model::DataTypes::GenericEntity,
                                  :format_data_types_generic_entity
          base.register_formatter Model::DataTypes::Generic,
                                  :format_data_types_generic
          base.register_formatter Model::DataTypes::Integer,
                                  :format_data_types_integer
          base.register_formatter Model::DataTypes::List,
                                  :format_data_types_list
          base.register_formatter Model::DataTypes::Logical,
                                  :format_data_types_logical
          base.register_formatter Model::DataTypes::Number,
                                  :format_data_types_number
          base.register_formatter Model::DataTypes::Real,
                                  :format_data_types_real
          base.register_formatter Model::DataTypes::Select,
                                  :format_data_types_select
          base.register_formatter Model::DataTypes::Set, :format_data_types_set
          base.register_formatter Model::DataTypes::String,
                                  :format_data_types_string
        end

        def format_data_types_aggregate(node)
          [
            "AGGREGATE",
            *if node.base_type
               [
                 " ",
                 "OF",
                 " ",
                 format(node.base_type),
               ]
             end,
          ].join
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
                        list_item_lines(node.items, item_indent),
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
                        list_item_lines(node.items, item_indent),
                        ")",
                      ].join),
                    ].join
                  end,
               ].join
             end,
          ].join
        end

        # The items of an ENUMERATION or of a SELECT, one a line. A remark
        # that follows an item on its line is written after the comma. The
        # remark of the last item is written after the `;` of the TYPE
        # ({#last_list_item_remark}): before it, a tail remark would take
        # the `)` and the `;` with it.
        def list_item_lines(items, item_indent)
          last = items.length - 1
          items.each_with_index.map do |item, i|
            text = list_item_text(item, item_indent)
            i == last ? text : "#{text},#{format_list_item_remarks(item)}"
          end.join("\n#{item_indent}")
        end

        # An item with the remarks that stand on lines of their own above
        # it. Each remark and the item start at the depth of the items; the
        # lines inside a remark of several lines are left as they are.
        def list_item_text(item, item_indent)
          leading = format_leading_statement_remarks(item)
          return format(item) if leading.empty?

          own = format(item).delete_prefix("#{leading.join("\n")}\n")
          [*leading, own].join("\n#{item_indent}")
        end

        # The remark that follows the last item of a TYPE's ENUMERATION or
        # SELECT.
        def last_list_item_remark(type)
          list = type.underlying_type
          return "" unless list.is_a?(Model::DataTypes::Enumeration) ||
            list.is_a?(Model::DataTypes::Select)

          item = Array(list.items).last
          item ? format_list_item_remarks(item) : ""
        end

        # An item of an ENUMERATION, or a reference: the items of a SELECT
        # are references, and the attacher places an inline remark on a
        # reference only there.
        def list_item?(node)
          node.is_a?(Model::DataTypes::EnumerationItem) ||
            node.is_a?(Model::References::SimpleReference)
        end

        def format_data_types_enumeration_item(node)
          # no_remarks strips remark blocks everywhere else
          # (format_remark_items, format_remark_item on the core
          # formatter); this direct format(item) path is the one
          # formatter that could still leak WG12 blocks into stripped
          # output.
          return node.id if @no_remarks
          return node.id unless node.respond_to?(:remark_items) && Array(node.remark_items).any?

          [
            node.id,
            *Array(node.remark_items).map { |item| ["\n", format(item)].join },
          ].join
        end

        def format_data_types_generic_entity(node)
          [
            "GENERIC_ENTITY",
            *if node.id
               [
                 " : ",
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
                 " : ",
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
          items = Array(node.items)
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
                 *if items.length.positive?
                    item_indent = indent_char * "(".length
                    [
                      " ",
                      "WITH",
                      "\n",
                      indent([
                        "(",
                        list_item_lines(items, item_indent),
                        ")",
                      ].join),
                    ].join
                  end,
               ].join
             elsif items.length.positive?
               indent_char = self.class.const_get(:INDENT_CHAR)
               item_indent = indent_char * "(".length
               [
                 "\n",
                 indent([
                   "(",
                   list_item_lines(items, item_indent),
                   ")",
                 ].join),
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
end
