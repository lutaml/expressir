module Expressir
  module Model
    class Repository
      include Scope

      attr_accessor :schemas

      def initialize(options = {})
        @schemas = options[:schemas]
      end

      def children
        items = []
        items.push(*@schemas) if @schemas
        items
      end
    end
  end
end