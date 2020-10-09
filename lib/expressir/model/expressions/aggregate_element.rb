module Expressir
    module Model
      module Expressions
        class AggregateElement
          attr_accessor :expression
          attr_accessor :repetition
  
          def initialize(options = {})
            @expression = options[:expression]
            @repetition = options[:repetition]
          end
        end
      end
    end
  end