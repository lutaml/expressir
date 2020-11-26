module Expressir
  module Model
    class Entity
      include Scope
      include Identifier

      attr_accessor :abstract
      attr_accessor :supertype_expression
      attr_accessor :subtype_of
      attr_accessor :attributes
      attr_accessor :unique
      attr_accessor :where

      def initialize(options = {})
        @id = options[:id]

        @abstract = options[:abstract]
        @supertype_expression = options[:supertype_expression]
        @subtype_of = options[:subtype_of]
        @attributes = options[:attributes]
        @unique = options[:unique]
        @where = options[:where]
      end

      def explicit_attributes
        @attributes.select{|x| x.kind == Expressir::Model::Attribute::EXPLICIT}
      end

      def derived_attributes
        @attributes.select{|x| x.kind == Expressir::Model::Attribute::DERIVED}
      end

      def inverse_attributes
        @attributes.select{|x| x.kind == Expressir::Model::Attribute::INVERSE}
      end

      def children
        items = []
        items.push(*@attributes) if @attributes
        items.push(*@unique) if @unique
        items.push(*@where) if @where
        items
      end
    end
  end
end