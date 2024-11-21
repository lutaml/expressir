module Expressir
  module Model
    module SupertypeExpressions
      # Specified in ISO 10303-11:2004
      # - section 9.2.5.2 ONEOF
      class OneofSupertypeExpression < SupertypeExpression
        model_attr_accessor :operands, "Array<SupertypeExpression>"

        # @param [Hash] options
        # @option options [Array<SupertypeExpression>] :operands
        def initialize(options = {})
          @operands = options[:operands]

          super
        end
      end
    end
  end
end
