module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2 Entity declaration
      class Entity < ModelElement
        include Identifier

        attribute :abstract, :boolean
        attribute :supertype_expression, ModelElement
        attribute :subtype_of, ModelElement, collection: true
        attribute :attributes, Attribute, collection: true
        attribute :unique_rules, UniqueRule, collection: true
        attribute :where_rules, WhereRule, collection: true
        attribute :informal_propositions, RemarkItem, collection: true
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "abstract", to: :abstract
          map "supertype_expression", to: :supertype_expression
          map "subtype_of", to: :subtype_of
          map "attributes", to: :attributes
          map "unique_rules", to: :unique_rules
          map "where_rules", to: :where_rules
          map "informal_propositions", to: :informal_propositions
        end

        # @return [Array<Declaration>]
        def children
          [
            *attributes,
            *unique_rules,
            *where_rules,
            *informal_propositions,
            *remark_items,
          ]
        end
      end
    end
  end
end
