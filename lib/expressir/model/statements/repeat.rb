module Expressir
  module Model
    module Statements
      class Repeat
        attr_accessor :id
        attr_accessor :bound1
        attr_accessor :bound2
        attr_accessor :increment
        attr_accessor :while_expression
        attr_accessor :until_expression
        attr_accessor :statements

        attr_accessor :parent
        attr_accessor :remarks

        def initialize(options = {})
          @id = options[:id]
          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @increment = options[:increment]
          @while_expression = options[:while_expression]
          @until_expression = options[:until_expression]
          @statements = options[:statements]
        end

        def children
          items = []
          items.push(self)
          items
        end
      end
    end
  end
end