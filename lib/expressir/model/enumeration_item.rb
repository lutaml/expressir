module Expressir
  module Model
    class EnumerationItem < ModelElement
      include Identifier

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

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