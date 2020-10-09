module Expressir
  module Model
    module Statements
      class Alias
        attr_accessor :id
        attr_accessor :expression
        attr_accessor :statements

        def initialize(options = {})
          @id = options[:id]
          @expression = options[:expression]
          @statements = options[:statements]
        end
      end
    end
  end
end