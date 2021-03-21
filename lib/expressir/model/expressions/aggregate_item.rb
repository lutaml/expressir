module Expressir
  module Model
    module Expressions
      class AggregateItem < ModelElement
        model_attr_accessor :expression
        model_attr_accessor :repetition

        def initialize(options = {})
          @expression = options[:expression]
          @repetition = options[:repetition]

          super
        end
      end
    end
  end
end