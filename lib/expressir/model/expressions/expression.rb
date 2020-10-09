module Expressir
  module Model
    module Expressions
      class Expression
        attr_accessor :operator
        attr_accessor :operands

        def initialize(options = {})
          @operator = options[:operator]
          @operands = options[:operands]
        end
      end
    end
  end
end