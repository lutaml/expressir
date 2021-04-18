module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.1 Arithmetic operators
      # - section 12.4.1 NOT operator
      class UnaryExpression < Expression
        MINUS = :MINUS
        NOT = :NOT
        PLUS = :PLUS

        model_attr_accessor :operator, ':MINUS, :NOT, :PLUS'
        model_attr_accessor :operand, 'Expression'

        # @param [Hash] options
        # @option options [:MINUS, :NOT, :PLUS] :operator
        # @option options [Expression] :operand
        def initialize(options = {})
          @operator = options[:operator]
          @operand = options[:operand]

          super
        end
      end
    end
  end
end