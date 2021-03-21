module Expressir
  module Model
    module Statements
      class Compound < ModelElement
        model_attr_accessor :statements

        def initialize(options = {})
          @statements = options.fetch(:statements, [])

          super
        end
      end
    end
  end
end