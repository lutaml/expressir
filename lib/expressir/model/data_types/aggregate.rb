module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 9.5.3.1 Aggregate data type
      class Aggregate < DataType
        include Identifier

        attribute :base_type, Expressir::Model::Declarations::Type

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
