module Expressir
  module Model
    class Type < ModelElement
      include Identifier

      attr_accessor :type
      attr_accessor :where
      attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @type = options[:type]
        @where = options.fetch(:where, [])
        @informal_propositions = options.fetch(:informal_propositions, [])

        super
      end

      def children
        items = []
        items.push(*@type.is_a?(Types::Enumeration) ? @type.items : [])
        items.push(*@where)
        items.push(*@informal_propositions)
        items
      end
    end
  end
end