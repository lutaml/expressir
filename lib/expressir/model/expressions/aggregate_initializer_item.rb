module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.9 Aggregate initializer
      class AggregateInitializerItem < Expression
        model_attr_accessor :expression, 'Expression'
        model_attr_accessor :repetition, 'Expression'

        # @param [Hash] options
        # @option options [Expression] :expression
        # @option options [Expression] :repetition
        def initialize(options = {})
          @expression = options[:expression]
          @repetition = options[:repetition]

          super
        end
      end
    end
  end
end