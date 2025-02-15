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
