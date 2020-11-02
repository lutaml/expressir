module Expressir
  module Model
    class Entity
      attr_accessor :id
      attr_accessor :abstract
      attr_accessor :abstract_supertype
      attr_accessor :supertypes
      attr_accessor :subtype_expression
      attr_accessor :explicit
      attr_accessor :derived
      attr_accessor :inverse
      attr_accessor :unique
      attr_accessor :where
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @abstract = options[:abstract]
        @abstract_supertype = options[:abstract_supertype]
        @supertypes = options[:supertypes]
        @subtype_expression = options[:subtype_expression]
        @explicit = options[:explicit]
        @derived = options[:derived]
        @inverse = options[:inverse]
        @unique = options[:unique]
        @where = options[:where]
        @remarks = options[:remarks]
      end

      def scope_items
        items = []
        items.push(*@explicit) if @explicit
        items.push(*@derived) if @derived
        items.push(*@inverse) if @inverse
        items.push(*@unique) if @unique
        items.push(*@where) if @where
        items
      end
    end
  end
end