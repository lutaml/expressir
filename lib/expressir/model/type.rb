module Expressir
  module Model
    class Type
      attr_accessor :id
      attr_accessor :type
      attr_accessor :where

      attr_accessor :parent
      attr_accessor :remarks

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