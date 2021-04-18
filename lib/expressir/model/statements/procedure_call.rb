module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.8 Procedure call statement
      class ProcedureCall < Statement
        model_attr_accessor :procedure, 'Reference'
        model_attr_accessor :parameters, 'Array<Expression>'

        # @param [Hash] options
        # @option options [Reference] :procedure
        # @option options [Array<Expression>] :parameters
        def initialize(options = {})
          @procedure = options[:procedure]
          @parameters = options[:parameters] || []

          super
        end
      end
    end
  end
end