module Expressir
  module Model
    class Entity < ModelElement
      include Identifier

      attr_accessor :abstract
      attr_accessor :supertype_expression
      attr_accessor :subtype_of
      attr_accessor :attributes
      attr_accessor :unique
      attr_accessor :where
      attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
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
          *informal_propositions
        ]
      end
    end
  end
end