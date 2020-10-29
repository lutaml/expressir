module Expressir
  module Model
    class Repository
      attr_accessor :schemas

      def initialize(options = {})
        @schemas = options[:schemas]
      end

      def scope_items
        items = []
        items.push(*@schemas) if @schemas
        items
      end
    end
  end
end