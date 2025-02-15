module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 9.5.3.2 Generic data type
      class Generic < DataType
        include Identifier

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
