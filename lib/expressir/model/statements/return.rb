module Expressir
  module Model
    module Statements
      class Return
        attr_accessor :expression

        def initialize(options = {})
          @expression = options[:expression]
        end
      end
    end
  end
end