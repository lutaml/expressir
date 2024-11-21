module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.7 If ... Then ... Else statement
      class If < Statement
        model_attr_accessor :expression, "Expression"
        model_attr_accessor :statements, "Array<Statement>"
        model_attr_accessor :else_statements, "Array<Statement>"

        # @param [Hash] options
        # @option options [Expression] :expression
        # @option options [Array<Statement>] :statements
        # @option options [Array<Statement>] :else_statements
        def initialize(options = {})
          @expression = options[:expression]
          @statements = options[:statements] || []
          @else_statements = options[:else_statements] || []

          super
        end
      end
    end
  end
end
