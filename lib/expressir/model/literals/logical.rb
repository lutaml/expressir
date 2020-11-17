module Expressir
  module Model
    module Literals
      class Logical
        TRUE = :TRUE
        FALSE = :FALSE
        UNKNOWN = :UNKNOWN

        attr_accessor :value

        def initialize(options = {})
          @value = options[:value]
        end
      end
    end
  end
end