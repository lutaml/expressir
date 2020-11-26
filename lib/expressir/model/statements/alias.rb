module Expressir
  module Model
    module Statements
      class Alias
        include Scope
        include Identifier

        attr_accessor :expression
        attr_accessor :statements

        def initialize(options = {})
          @id = options[:id]

          @expression = options[:expression]
          @statements = options[:statements]
        end

        def children
          items = []
          items.push(self)
          items
        end
      end
    end
  end
end