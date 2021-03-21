module Expressir
  module Model
    module Expressions
      class SimpleReference < ModelElement
        model_attr_accessor :id

        model_attr_accessor :base_path

        def initialize(options = {})
          @id = options[:id]

          @base_path = options[:base_path]

          super
        end
      end
    end
  end
end