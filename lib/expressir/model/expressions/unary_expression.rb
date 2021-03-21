module Expressir
  module Model
    module Expressions
      class UnaryExpression < ModelElement
        MINUS = :MINUS
        NOT = :NOT
        PLUS = :PLUS

        model_attr_accessor :operator
        model_attr_accessor :operand

        def initialize(options = {})
          @operator = options[:operator]
          @operand = options[:operand]

          super
        end
      end
    end
  end
end