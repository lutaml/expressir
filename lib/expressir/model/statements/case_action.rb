module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.4 Case statement
      class CaseAction < ModelElement
        model_attr_accessor :labels, "Array<Expression>"
        model_attr_accessor :statement, "Statement"

        # @param [Hash] options
        # @option options [Array<Expression>] :labels
        # @option options [Statement] :statement
        def initialize(options = {})
          @labels = options[:labels] || []
          @statement = options[:statement]

          super
        end
      end
    end
  end
end
