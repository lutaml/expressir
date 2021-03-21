module Expressir
  module Model
    module Expressions
      class SimpleReference < ModelElement
        model_attr_accessor :id

        def initialize(options = {})
          @id = options[:id]

          super
        end
      end
    end
  end
end