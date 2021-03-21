module Expressir
  module Model
    class Unique < ModelElement
      include Identifier

      model_attr_accessor :attributes

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @attributes = options.fetch(:attributes, [])

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