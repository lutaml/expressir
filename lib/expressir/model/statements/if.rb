module Expressir
  module Model
    module Statements
      class If
        attr_accessor :expression
        attr_accessor :statements
        attr_accessor :else_statements

        def initialize(options = {})
          @expression = options[:expression]
          @statements = options[:statements]
          @else_statements = options[:else_statements]
        end
      end
    end
  end
end