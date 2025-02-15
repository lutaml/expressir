module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.4 Constant
      class Constant < ::Expressir::Model::Declaration
        include Identifier

        attribute :type, ::Expressir::Model::DataType
        attribute :expression, ::Expressir::Model::Expression

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
