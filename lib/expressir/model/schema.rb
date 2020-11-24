module Expressir
  module Model
    class Schema
      attr_accessor :id
      attr_accessor :version
      attr_accessor :interfaces
      attr_accessor :constants
      attr_accessor :declarations

      attr_accessor :remarks

      def initialize(options = {})
        @id = options[:id]
        @version = options[:version]
        @interfaces = options[:interfaces]
        @constants = options[:constants]
        @declarations = options[:declarations]
      end

      def use_interfaces
        @interfaces.select{|x| x.kind == Expressir::Model::Interface::USE}
      end

      def reference_interfaces
        @interfaces.select{|x| x.kind == Expressir::Model::Interface::REFERENCE}
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

      def rules
        @declarations.select{|x| x.instance_of? Expressir::Model::Rule}
      end

      def children
        items = []
        items.push(*@constants) if @constants
        items.push(*@declarations.flat_map do |x|
          [
            x,
            *if x.instance_of? Expressir::Model::Type and x.type.instance_of? Expressir::Model::Types::Enumeration
              x.type.items
            end
          ]
        end) if @declarations
        items
      end
    end
  end
end