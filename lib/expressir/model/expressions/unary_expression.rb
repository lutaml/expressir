module Expressir
  module Model
    module Expressions
      class UnaryExpression < ModelElement
        MINUS = :MINUS
        NOT = :NOT
        PLUS = :PLUS

        attr_accessor :operator
        attr_accessor :operand

        def initialize(options = {})
          @operator = options[:operator]
          @operand = options[:operand]
        end
      end
    end
  end
end