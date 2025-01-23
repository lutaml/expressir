module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.8 Function call
      class FunctionCall < Expression
        model_attr_accessor :function, "Reference"
        model_attr_accessor :parameters, "Array<Expression>"

        # @param [Hash] options
        # @option options [Reference] :function
        # @option options [Array<Expression>] :parameters
        def initialize(options = {})
          @function = options[:function]
          @parameters = options[:parameters]

          super
        end
      end
    end
  end
end
