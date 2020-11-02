module Expressir
  module Model
    module Statements
      class Alias
        attr_accessor :id
        attr_accessor :expression
        attr_accessor :statements
        attr_accessor :remarks

        def initialize(options = {})
          @id = options[:id]
          @expression = options[:expression]
          @statements = options[:statements]
          @remarks = options[:remarks]
        end

        def scope_items
          items = []
          items.push(self)
          items
        end
      end
    end
  end
end