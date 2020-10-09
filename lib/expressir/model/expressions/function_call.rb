module Expressir
  module Model
    module Expressions
      class FunctionCall
        attr_accessor :function
        attr_accessor :parameters

        def initialize(options = {})
          @function = options[:function]
          @parameters = options[:parameters]
        end
      end
    end
  end
end