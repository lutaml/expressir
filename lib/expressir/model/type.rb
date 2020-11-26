module Expressir
  module Model
    class Type
      include Scope
      include Identifier

      attr_accessor :type
      attr_accessor :where

      def initialize(options = {})
        @id = options[:id]

        @type = options[:type]
        @where = options[:where]
      end

      def children
        items = []
        items.push(*@where) if @where
        items
      end
    end
  end
end