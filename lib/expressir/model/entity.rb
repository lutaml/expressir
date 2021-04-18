module Expressir
  module Model
    class Entity < ModelElement
      include Identifier

      model_attr_accessor :abstract
      model_attr_accessor :supertype_expression
      model_attr_accessor :subtype_of
      model_attr_accessor :attributes
      model_attr_accessor :unique_rules
      model_attr_accessor :where_rules
      model_attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options[:remarks] || []
        @remark_items = options[:remark_items] || []
        @source = options[:source]

        @abstract = options[:abstract]
        @supertype_expression = options[:supertype_expression]
        @subtype_of = options[:subtype_of] || []
        @attributes = options[:attributes] || []
        @unique_rules = options[:unique_rules] || []
        @where_rules = options[:where_rules] || []
        @informal_propositions = options[:informal_propositions] || []

        super
      end

      def children
        [
          *attributes,
          *unique_rules,
          *where_rules,
          *informal_propositions,
          *remark_items
        ]
      end
    end
  end
end