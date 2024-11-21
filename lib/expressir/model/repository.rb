module Expressir
  module Model
    # Multi-schema global scope
    class Repository < ModelElement
      model_attr_accessor :schemas, "Array<Declarations::Schema>"

      # @param [Hash] options
      # @option options [Array<Declarations::Schema>] :schemas
      def initialize(options = {})
        @schemas = options[:schemas] || []

        super
      end

      # @return [Array<Declaration>]
      def children
        [
          *schemas,
        ]
      end
    end
  end
end
