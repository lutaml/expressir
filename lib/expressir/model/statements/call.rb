module Expressir
  module Model
    module Statements
      class Call < ModelElement
        model_attr_accessor :ref
        model_attr_accessor :parameters

        def initialize(options = {})
          @ref = options[:ref]
          @parameters = options[:parameters] || []

          super
        end
      end
    end
  end
end