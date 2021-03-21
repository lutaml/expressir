module Expressir
  module Model
    class SubtypeConstraint < ModelElement
      include Identifier

      model_attr_accessor :applies_to
      model_attr_accessor :abstract
      model_attr_accessor :total_over
      model_attr_accessor :supertype_expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @applies_to = options[:applies_to]
        @abstract = options[:abstract]
        @total_over = options.fetch(:total_over, [])
        @supertype_expression = options[:supertype_expression]

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