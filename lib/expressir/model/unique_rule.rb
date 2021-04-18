module Expressir
  module Model
    class UniqueRule < ModelElement
      include Identifier

      model_attr_accessor :attributes

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]

        @attributes = options[:attributes] || []

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