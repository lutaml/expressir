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
