module Expressir
  module Model
    module Literals
      class Binary < ModelElement
        attr_accessor :value

        def initialize(options = {})
          @value = options[:value]

          super
        end
      end
    end
  end
end