module Expressir
  module Model
    class Repository < ModelElement
      include Scope

      attr_accessor :schemas

      def initialize(options = {})
        @schemas = options.fetch(:schemas, [])
      end

      def children
        items = []
        items.push(*@schemas)
        items
      end
    end
  end
end