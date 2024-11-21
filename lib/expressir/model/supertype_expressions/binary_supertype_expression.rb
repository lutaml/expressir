module Expressir
  module Model
    module SupertypeExpressions
      # Specified in ISO 10303-11:2004
      # - section 9.2.5.3 ANDOR
      # - section 9.2.5.4 AND
      class BinarySupertypeExpression < SupertypeExpression
        AND = :AND
        ANDOR = :ANDOR

        model_attr_accessor :operator, ":AND, :ANDOR"
        model_attr_accessor :operand1, "SupertypeExpression"
        model_attr_accessor :operand2, "SupertypeExpression"

        # @param [Hash] options
        # @option options [:AND, :ANDOR] :operator
        # @option options [SupertypeExpression] :operand1
        # @option options [SupertypeExpression] :operand2
        def initialize(options = {})
          @operator = options[:operator]
          @operand1 = options[:operand1]
          @operand2 = options[:operand2]

          super
        end
      end
    end
  end
end
