module Expressir
  module Model
    class Repository < ModelElement
      attr_accessor :schemas

      def initialize(options = {})
        @schemas = options.fetch(:schemas, [])

        super
      end

      def children
        [
          *schemas
        ]
      end
    end
  end
end