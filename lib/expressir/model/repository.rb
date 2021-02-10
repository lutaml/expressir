module Expressir
  module Model
    class Repository < ModelElement
      attr_accessor :schemas

      def initialize(options = {})
        @schemas = options.fetch(:schemas, [])

        super
      end

      def children
        items = []
        items.push(*@schemas)
        items
      end
    end
  end
end