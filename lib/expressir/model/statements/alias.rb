module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.2 Alias statement
      class Alias < Statement
        include Identifier

        model_attr_accessor :expression, "Expression"
        model_attr_accessor :statements, "Array<Statement>"

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Expression] :expression
        # @option options [Array<Statement>] :statements
        def initialize(options = {})
          initialize_identifier(options)

          @expression = options[:expression]
          @statements = options[:statements] || []

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            self,
            *remark_items,
          ]
        end
      end
    end
  end
end
