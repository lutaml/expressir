module Expressir
  module Model
    class Rule
      attr_accessor :id
      attr_accessor :applies_to
      attr_accessor :declarations
      attr_accessor :constants
      attr_accessor :locals
      attr_accessor :where
      attr_accessor :statements
      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @applies_to = options[:applies_to]
        @declarations = options[:declarations]
        @constants = options[:constants]
        @locals = options[:locals]
        @where = options[:where]
        @statements = options[:statements]
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
        items.push(*@declarations) if @declarations
        items.push(*@constants) if @constants
        items.push(*@locals) if @locals
        items.push(*@where) if @where
        # TODO: statements
        items
      end
    end
  end
end