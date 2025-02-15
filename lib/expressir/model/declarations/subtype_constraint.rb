module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.7 Subtype constraints
      class SubtypeConstraint < ::Expressir::Model::Declaration
        include Identifier

        attribute :applies_to, ::Expressir::Model::Reference
        attribute :abstract, :boolean
        attribute :total_over, ::Expressir::Model::Reference, collection: true
        attribute :supertype_expression, ::Expressir::Model::SupertypeExpression

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
