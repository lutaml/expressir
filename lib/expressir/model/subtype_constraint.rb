module Expressir
  module Model
    class SubtypeConstraint < ModelElement
      include Scope
      include Identifier

      attr_accessor :applies_to
      attr_accessor :abstract
      attr_accessor :total_over
      attr_accessor :supertype_expression

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @applies_to = options[:applies_to]
        @abstract = options[:abstract]
        @total_over = options[:total_over]
        @supertype_expression = options[:supertype_expression]
      end

      def children
        items = []
        items
      end
    end
  end
end