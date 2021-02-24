module Expressir
  module Model
    module Statements
      class Return < ModelElement
        attr_accessor :expression

        def initialize(options = {})
          @expression = options[:expression]

          super
        end
      end
    end
  end
end