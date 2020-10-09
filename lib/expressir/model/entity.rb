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
      end
    end
  end
end