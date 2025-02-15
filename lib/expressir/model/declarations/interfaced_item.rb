module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class InterfacedItem < ModelElement
        attribute :id, :string
        attribute :remarks, :string, collection: true
        attribute :remark_items, RemarkItem, collection: true
        attribute :base_item, ModelElement

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
