module Expressir
  module Model
    module Expressions
      class IndexReference < ModelElement
        model_attr_accessor :ref
        model_attr_accessor :index1
        model_attr_accessor :index2

        def initialize(options = {})
          @ref = options[:ref]
          @index1 = options[:index1]
          @index2 = options[:index2]

          super
        end
      end
    end
  end
end