module Expressir
  module Model
    class Type
      include Scope
      include Identifier

      attr_accessor :type
      attr_accessor :where
      attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]

        @type = options[:type]
        @where = options[:where]
        @informal_propositions = options[:informal_propositions]
      end

      def children
        items = []
        items.push(*@where) if @where
        items.push(*@informal_propositions) if @informal_propositions
        items
      end
    end
  end
end