module Expressir
  module Model
    class Variable < ModelElement
      include Identifier

      model_attr_accessor :type
      model_attr_accessor :expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @type = options[:type]
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