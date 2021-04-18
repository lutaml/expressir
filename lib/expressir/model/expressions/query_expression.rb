module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.6.7 Query expression
      class QueryExpression < Expression
        include Identifier

        model_attr_accessor :aggregate_source, 'Reference'
        model_attr_accessor :expression, 'Expression'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Reference] :aggregace_source
        # @option options [Expression] :expression
        def initialize(options = {})
          initialize_identifier(options)

          @aggregate_source = options[:aggregate_source]
          @expression = options[:expression]

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            self,
            *remark_items
          ]
        end
      end
    end
  end
end