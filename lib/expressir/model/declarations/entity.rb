module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2 Entity declaration
      class Entity < ::Expressir::Model::Declaration
        include Identifier

        attribute :abstract, :boolean
        attribute :supertype_expression, ::Expressir::Model::SupertypeExpression
        attribute :subtype_of, ::Expressir::Model::Reference, collection: true
        attribute :attributes, ::Expressir::Model::Declarations::Attribute, collection: true
        attribute :unique_rules, ::Expressir::Model::Declarations::UniqueRule, collection: true
        attribute :where_rules, ::Expressir::Model::Declarations::WhereRule, collection: true
        attribute :informal_propositions, ::Expressir::Model::Declarations::RemarkItem, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
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
