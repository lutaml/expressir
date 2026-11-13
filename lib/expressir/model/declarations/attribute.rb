module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.1 Attributes
      class Attribute < ModelElement
        include Identifier

        EXPLICIT = "EXPLICIT".freeze
        DERIVED = "DERIVED".freeze
        INVERSE = "INVERSE".freeze

        attribute :kind, :string, values: %w[EXPLICIT DERIVED INVERSE]
        attribute :supertype_attribute, ModelElement
        attribute :optional, :boolean
        attribute :type, ModelElement
        attribute :expression, ModelElement
        # ISO 10303-11 allows one declaration to list several names
        # (explicit_attr's attribute_decl list). The builder splits them into
        # one node per name so references resolve per name; siblings of one
        # source declaration share this group number so the formatters can
        # print the combined declaration (#655).
        attribute :declaration_group, :integer
        attribute :_class, :string, default: -> { self.class.name }

        key_value do
          map "_class", to: :_class, render_default: true
          map "declaration_group", to: :declaration_group
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
