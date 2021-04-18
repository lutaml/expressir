module Expressir
  module Model
      # Specified in ISO 10303-11:2004
      # - section 10 Scope and visibility
      # - section 10.3.13 Schema
    class Repository < ModelElement
      model_attr_accessor :schemas, 'Array<Schema>'

      # @param [Hash] options
      # @option options [Array<Schema>] :schemas
      def initialize(options = {})
        @schemas = options[:schemas] || []

        super
      end

      # @return [Array<Declaration>]
      def children
        [
          *schemas
        ]
      end
    end
  end
end