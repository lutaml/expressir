module Expressir
  module Model
    class Where < ModelElement
      include Identifier

      model_attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
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