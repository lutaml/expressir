module Expressir
  module Model
    module Literals
      class String
        attr_accessor :value
        attr_accessor :encoded

        def initialize(options = {})
          @value = options[:value]
          @encoded = options[:encoded]
        end
      end
    end
  end
end