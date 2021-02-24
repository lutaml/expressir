module Expressir
  module Model
    module Statements
      class Assignment < ModelElement
        attr_accessor :ref
        attr_accessor :expression

        def initialize(options = {})
          @ref = options[:ref]
          @expression = options[:expression]

          super
        end
      end
    end
  end
end