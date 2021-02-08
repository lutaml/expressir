module Expressir
  module Model
    module Statements
      class Repeat < ModelElement
        include Scope
        include Identifier

        attr_accessor :bound1
        attr_accessor :bound2
        attr_accessor :increment
        attr_accessor :while_expression
        attr_accessor :until_expression
        attr_accessor :statements

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @source = options[:source]

          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @increment = options[:increment]
          @while_expression = options[:while_expression]
          @until_expression = options[:until_expression]
          @statements = options.fetch(:statements, [])
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