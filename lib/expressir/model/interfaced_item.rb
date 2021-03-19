module Expressir
  module Model
    class InterfacedItem < ModelElement
      attr_accessor :id
      attr_accessor :remarks
      attr_accessor :remark_items

      attr_accessor :base_item

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])

        @base_item = options[:base_item]

        super
      end

      def path
        base_item.path
      end

      def children
        [
          *remark_items
        ]
      end
    end
  end
end