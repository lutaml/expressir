module Expressir
  module Model
    class SubtypeConstraint
      attr_accessor :id
      attr_accessor :applies_to
      attr_accessor :abstract_supertype
      attr_accessor :total_over
      attr_accessor :subtype_expression
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @applies_to = options[:applies_to]
        @abstract_supertype = options[:abstract_supertype]
        @total_over = options[:total_over]
        @subtype_expression = options[:subtype_expression]
        @remarks = options[:remarks]
      end
    end
  end
end