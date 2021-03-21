module Expressir
  module Model
    module Statements
      class Assignment < ModelElement
        model_attr_accessor :ref
        model_attr_accessor :expression

        def initialize(options = {})
          @ref = options[:ref]
          @expression = options[:expression]

          super
        end
      end
    end
  end
end