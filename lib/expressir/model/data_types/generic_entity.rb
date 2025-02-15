module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 9.5.3.3 Generic entity data type
      class GenericEntity < DataType
        include Identifier
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
