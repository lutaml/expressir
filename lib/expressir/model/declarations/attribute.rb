module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.1 Attributes
      class Attribute < ::Expressir::Model::Declaration
        include Identifier

        EXPLICIT = "EXPLICIT"
        DERIVED = "DERIVED"
        INVERSE = "INVERSE"

        attribute :kind, :string, values: %w[EXPLICIT DERIVED INVERSE]
        attribute :supertype_attribute, ::Expressir::Model::Reference
        attribute :optional, :boolean
        attribute :type, DataType
        attribute :expression, Expression
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "kind", to: :kind
          map "supertype_attribute", to: :supertype_attribute
          map "optional", to: :optional
          map "type", to: :type
          map "expression", to: :expression
        end

        # @return [Array<Declaration>]
        def children
          [
            *remark_items,
          ]
        end
      end
    end
  end
end
