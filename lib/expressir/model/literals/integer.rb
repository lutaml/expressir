module Expressir
  module Model
    module Literals
      class Integer < ModelElement
        attr_accessor :value

        def initialize(options = {})
          @value = options[:value]
        end
      end
    end
  end
end