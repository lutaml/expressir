module Expressir
  module Model
    class Schema
      attr_accessor :id
      attr_accessor :version
      attr_accessor :interfaces
      attr_accessor :constants
      attr_accessor :declarations
      attr_accessor :rules
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @version = options[:version]
        @interfaces = options[:interfaces]
        @constants = options[:constants]
        @declarations = options[:declarations]
        @rules = options[:rules]
        @remarks = options[:remarks]
      end

      def types
        @declarations.select{|x| x.instance_of? Expressir::Model::Type}
      end

      def entities
        @declarations.select{|x| x.instance_of? Expressir::Model::Entity}
      end

      def subtype_constraints
        @declarations.select{|x| x.instance_of? Expressir::Model::SubtypeConstraint}
      end

      def functions
        @declarations.select{|x| x.instance_of? Expressir::Model::Function}
      end

      def procedures
        @declarations.select{|x| x.instance_of? Expressir::Model::Procedure}
      end

      def scope_items
        items = []
        items.push(*@constants) if @constants
        items.push(*@declarations) if @declarations
        items.push(*@rules) if @rules
        items
      end
    end
  end
end