module Expressir
  module Model
    module Types
      class Generic
        attr_accessor :label

        attr_accessor :parent
        attr_accessor :remarks

        def initialize(options = {})
          @label = options[:label]
        end
      end
    end
  end
end