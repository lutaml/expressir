module Expressir
  module Model
    class InterfacedItem < ModelElement
      model_attr_accessor :id
      model_attr_accessor :remarks
      model_attr_accessor :remark_items

      model_attr_accessor :base_item

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