module Expressir
  module Model
    class Type
      attr_accessor :id
      attr_accessor :type
      attr_accessor :where
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @type = options[:type]
        @where = options[:where]
        @remarks = options[:remarks]
      end

      def scope_items
        items = []
        items.push(*@where) if @where
        items
      end
    end
  end
end