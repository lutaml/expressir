module Expressir
  module Model
    class Type < ModelElement
      include Identifier

      model_attr_accessor :underlying_type
      model_attr_accessor :where_rules
      model_attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]

        @underlying_type = options[:underlying_type]
        @where_rules = options[:where_rules] || []
        @informal_propositions = options[:informal_propositions] || []

        super
      end

      def enumeration_items
        underlying_type.is_a?(Types::Enumeration) ? underlying_type.items : []
      end

      def children
        [
          *enumeration_items,
          *where_rules,
          *informal_propositions,
          *remark_items
        ]
      end
    end
  end
end