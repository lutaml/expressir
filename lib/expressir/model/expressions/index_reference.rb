module Expressir
  module Model
    module Expressions
      class IndexReference < ModelElement
        attr_accessor :ref
        attr_accessor :index1
        attr_accessor :index2

        def initialize(options = {})
          @ref = options[:ref]
          @index1 = options[:index1]
          @index2 = options[:index2]
        end
      end
    end
  end
end