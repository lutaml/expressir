module Expressir
  module Model
    module Literals
      class Logical < ModelElement
        TRUE = :TRUE
        FALSE = :FALSE
        UNKNOWN = :UNKNOWN

        attr_accessor :value

        def initialize(options = {})
          @value = options[:value]

          super
        end
      end
    end
  end
end