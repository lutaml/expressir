module Expressir
  module Model
    class Type < ModelElement
      include Identifier

      model_attr_accessor :type
      model_attr_accessor :where
      model_attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]

        @type = options[:type]
        @where = options[:where] || []
        @informal_propositions = options[:informal_propositions] || []

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