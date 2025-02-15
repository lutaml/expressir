module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.2.1 Uniqueness rule
      class UniqueRule < ::Expressir::Model::Declaration
        include Identifier

        attribute :attributes, ::Expressir::Model::Reference

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
