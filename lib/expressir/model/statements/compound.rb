module Expressir
  module Model
    module Statements
      class Compound < ModelElement
        attr_accessor :statements

        def initialize(options = {})
          @statements = options.fetch(:statements, [])
        end
      end
    end
  end
end