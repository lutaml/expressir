module Expressir
  module Model
    module Statements
      class Case < ModelElement
        attr_accessor :expression
        attr_accessor :actions
        attr_accessor :otherwise_statement

        def initialize(options = {})
          @expression = options[:expression]
          @actions = options.fetch(:actions, [])
          @otherwise_statement = options[:otherwise_statement]

          super
        end
      end
    end
  end
end