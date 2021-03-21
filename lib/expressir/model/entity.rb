module Expressir
  module Model
    class Entity < ModelElement
      include Identifier

      model_attr_accessor :abstract
      model_attr_accessor :supertype_expression
      model_attr_accessor :subtype_of
      model_attr_accessor :attributes
      model_attr_accessor :unique
      model_attr_accessor :where
      model_attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @remark_items = options.fetch(:remark_items, [])
        @source = options[:source]

        @abstract = options[:abstract]
        @supertype_expression = options[:supertype_expression]
        @subtype_of = options.fetch(:subtype_of, [])
        @attributes = options.fetch(:attributes, [])
        @unique = options.fetch(:unique, [])
        @where = options.fetch(:where, [])
        @informal_propositions = options.fetch(:informal_propositions, [])

        super
      end

      def children
        [
          *attributes,
          *unique,
          *where,
          *informal_propositions,
          *remark_items
        ]
      end
    end
  end
end