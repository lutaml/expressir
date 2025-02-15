module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.1 Type declaration
      class Type < ::Expressir::Model::Declaration
        include Identifier

        attribute :underlying_type, ::Expressir::Model::DataType
        attribute :where_rules, ::Expressir::Model::Declarations::WhereRule, collection: true
        attribute :informal_propositions, ::Expressir::Model::Declarations::RemarkItem, collection: true

        # @return [Array<DataTypes::EnumerationItem>]
        def enumeration_items
          underlying_type.is_a?(DataTypes::Enumeration) ? underlying_type.items : []
        end

        # @return [Array<Declaration>]
        def children
          [
            *enumeration_items,
            *where_rules,
            *informal_propositions,
            *remark_items,
          ]
        end
      end
    end
  end
end
