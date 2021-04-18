module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.3 Assignment
      class Assignment < Statement
        model_attr_accessor :ref, 'Reference'
        model_attr_accessor :expression, 'Expression'

        # @param [Hash] options
        # @option options [Reference] :ref
        # @option options [Expression] :expression
        def initialize(options = {})
          @ref = options[:ref]
          @expression = options[:expression]

          super
        end
      end
    end
  end
end