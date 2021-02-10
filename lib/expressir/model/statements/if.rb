module Expressir
  module Model
    module Statements
      class If < ModelElement
        attr_accessor :expression
        attr_accessor :statements
        attr_accessor :else_statements

        def initialize(options = {})
          @expression = options[:expression]
          @statements = options.fetch(:statements, [])
          @else_statements = options.fetch(:else_statements, [])

          super
        end
      end
    end
  end
end