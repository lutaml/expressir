module Expressir
  module Model
    module Literals
      class String < ModelElement
        attr_accessor :value
        attr_accessor :encoded

        def initialize(options = {})
          @value = options[:value]
          @encoded = options[:encoded]

          super
        end
      end
    end
  end
end