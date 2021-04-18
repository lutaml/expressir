module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.5 Compound statement
      class Compound < Statement
        model_attr_accessor :statements, 'Array<Statement>'

        # @param [Hash] options
        # @option options [Array<Statement>] :statements
        def initialize(options = {})
          @statements = options[:statements] || []

          super
        end
      end
    end
  end
end