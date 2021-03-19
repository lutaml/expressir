module Expressir
  module Model
    class Where < ModelElement
      include Identifier

      attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @expression = options[:expression]

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