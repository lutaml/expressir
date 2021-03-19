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
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @type = options[:type]
        @where = options.fetch(:where, [])
        @informal_propositions = options.fetch(:informal_propositions, [])

        super
      end

      def enumeration_items
        type.is_a?(Types::Enumeration) ? type.items : []
      end

      def children
        [
          *enumeration_items,
          *where,
          *informal_propositions,
          *remark_items
        ]
      end
    end
  end
end