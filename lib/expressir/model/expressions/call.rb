module Expressir
  module Model
    module Expressions
      class Call < ModelElement
        model_attr_accessor :ref
        model_attr_accessor :parameters

        def initialize(options = {})
          @ref = options[:ref]
          @parameters = options.fetch(:parameters, [])

          super
        end
      end
    end
  end
end