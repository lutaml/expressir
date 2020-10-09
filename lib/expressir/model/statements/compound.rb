module Expressir
  module Model
    module Statements
      class Compound
        attr_accessor :statements

        def initialize(options = {})
          @statements = options[:statements]
        end
      end
    end
  end
end