module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.7 Subtype constraints
      class SubtypeConstraint < Declaration
        include Identifier

        model_attr_accessor :applies_to, "Reference"
        model_attr_accessor :abstract, "Boolean"
        model_attr_accessor :total_over, "Array<Reference>"
        model_attr_accessor :supertype_expression, "SupertypeExpression"

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Reference] :applies_to
        # @option options [Boolean] :abstract
        # @option options [Array<Reference>] :total_over
        # @option options [SupertypeExpression] :supertype_expression
        def initialize(options = {})
          initialize_identifier(options)

          @applies_to = options[:applies_to]
          @abstract = options[:abstract]
          @total_over = options[:total_over] || []
          @supertype_expression = options[:supertype_expression]

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *remark_items,
          ]
        end
      end
    end
  end
end
