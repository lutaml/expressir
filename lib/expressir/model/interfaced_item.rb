module Expressir
  module Model
    class InterfacedItem < ModelElement
      include Identifier

      attr_accessor :base_item

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @base_item = options[:base_item]

        super
      end

      def path
        base_item.path
      end
    end
  end
end