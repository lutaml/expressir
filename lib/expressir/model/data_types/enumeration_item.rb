module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.4.1 Enumeration data type
      class EnumerationItem < ModelElement
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
