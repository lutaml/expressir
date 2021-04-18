module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.4 Case statement
      class Case < Statement
        model_attr_accessor :expression, 'Expression'
        model_attr_accessor :actions, 'Array<CaseAction>'
        model_attr_accessor :otherwise_statement, 'Statement'

        # @param [Hash] options
        # @option options [Expression] :expression
        # @option options [Array<CaseAction>] :statements
        # @option options [Statement] :otherwise_statement
        def initialize(options = {})
          @expression = options[:expression]
          @actions = options[:actions] || []
          @otherwise_statement = options[:otherwise_statement]

          super
        end
      end
    end
  end
end