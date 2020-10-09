module Expressir
  module Model
    module Statements
      class Assignment
        attr_accessor :ref
        attr_accessor :expression

        def initialize(options = {})
          @ref = options[:ref]
          @expression = options[:expression]
        end
      end
    end
  end
end