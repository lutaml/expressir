module Expressir
  module Model
    module Types
      class Real < ModelElement
        model_attr_accessor :precision

        def initialize(options = {})
          @precision = options[:precision]

          super
        end
      end
    end
  end
end