module Expressir
  module Model
    module Expressions
      class IndexQualifier
        attr_accessor :index1
        attr_accessor :index2

        def initialize(options = {})
          @index1 = options[:index1]
          @index2 = options[:index2]
        end
      end
    end
  end
end