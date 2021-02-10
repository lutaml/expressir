module Expressir
  module Model
    module Statements
      class Alias < ModelElement
        include Identifier

        attr_accessor :expression
        attr_accessor :statements

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @source = options[:source]

          @expression = options[:expression]
          @statements = options.fetch(:statements, [])

          super
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