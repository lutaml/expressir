module Expressir
  module Model
    module Statements
      class Repeat
        attr_accessor :variable
        attr_accessor :bound1
        attr_accessor :bound2
        attr_accessor :increment
        attr_accessor :while_expression
        attr_accessor :until_expression
        attr_accessor :statements

        def initialize(options = {})
          @variable = options[:variable]
          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @increment = options[:increment]
          @while_expression = options[:while_expression]
          @until_expression = options[:until_expression]
          @statements = options[:statements]
        end
      end
    end
  end
end