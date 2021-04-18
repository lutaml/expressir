module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.10 Return statement
      class Return < Statement
        model_attr_accessor :expression, 'Expression'

        # @param [Hash] options
        # @option options [Expression] :expression
        def initialize(options = {})
          @expression = options[:expression]

          super
        end
      end
    end
  end
end