module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.9 Repeat statement
      class Repeat < Statement
        include Identifier

        model_attr_accessor :bound1, "Expression"
        model_attr_accessor :bound2, "Expression"
        model_attr_accessor :increment, "Expression"
        model_attr_accessor :while_expression, "Expression"
        model_attr_accessor :until_expression, "Expression"
        model_attr_accessor :statements, "Array<Statement>"

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Expression] :bound1
        # @option options [Expression] :bound2
        # @option options [Expression] :increment
        # @option options [Expression] :while_expression
        # @option options [Expression] :until_expression
        # @option options [Array<Statement>] :statements
        def initialize(options = {})
          initialize_identifier(options)

          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @increment = options[:increment]
          @while_expression = options[:while_expression]
          @until_expression = options[:until_expression]
          @statements = options[:statements] || []

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            self,
            *remark_items,
          ]
        end
      end
    end
  end
end
