module Expressir
  module Model
    module Expressions
      class SimpleReference < ModelElement
        attr_accessor :id

        def initialize(options = {})
          @id = options[:id]
        end
      end
    end
  end
end