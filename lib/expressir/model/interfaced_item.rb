module Expressir
  module Model
    class InterfacedItem < ModelElement
      model_attr_accessor :id
      model_attr_accessor :remarks
      model_attr_accessor :remark_items

      model_attr_accessor :base_item

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []

        @base_item = options[:base_item]

        super
      end

      def children
        [
          *remark_items
        ]
      end
    end
  end
end