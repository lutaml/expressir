module Expressir
  module Model
    module Literals
      class Real < ModelElement
        attr_accessor :value

        def initialize(options = {})
          @value = options[:value]

          super
        end
      end
    end
  end
end