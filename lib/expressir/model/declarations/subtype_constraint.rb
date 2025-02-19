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
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "applies_to", to: :applies_to
          map "abstract", to: :abstract
          map "total_over", to: :total_over
          map "supertype_expression", to: :supertype_expression
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
