module Expressir
  module Model
    module Types
      class Real
        attr_accessor :precision

        def initialize(options = {})
          @precision = options[:precision]
        end
      end
    end
  end
end