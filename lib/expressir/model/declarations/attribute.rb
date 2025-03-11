module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.1 Attributes
      class Attribute < ModelElement
        include Identifier

        EXPLICIT = "EXPLICIT"
        DERIVED = "DERIVED"
        INVERSE = "INVERSE"

        attribute :kind, :string, values: %w[EXPLICIT DERIVED INVERSE]
        attribute :supertype_attribute, ModelElement
        attribute :optional, :boolean
        attribute :type, ModelElement
        attribute :expression, ModelElement
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
