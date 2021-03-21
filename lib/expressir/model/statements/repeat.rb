module Expressir
  module Model
    module Statements
      class Repeat < ModelElement
        include Identifier

        model_attr_accessor :bound1
        model_attr_accessor :bound2
        model_attr_accessor :increment
        model_attr_accessor :while_expression
        model_attr_accessor :until_expression
        model_attr_accessor :statements

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @remark_items = options.fetch(:remark_items, [])
          @source = options[:source]

          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @increment = options[:increment]
          @while_expression = options[:while_expression]
          @until_expression = options[:until_expression]
          @statements = options.fetch(:statements, [])

          super
        end

        def children
          [
            self,
            *remark_items
          ]
        end
      end
    end
  end
end