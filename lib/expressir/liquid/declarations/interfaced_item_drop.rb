# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class InterfacedItemDrop < ::Expressir::Liquid::ModelElementDrop
        def initialize(model)
          @model = model
          super
        end

        def id
          @model.id
        end

        def remarks
          @model.remarks || []
        end

        def remark_items
          return [] unless @model.remark_items

          @model.remark_items.map do |item|
            ::Expressir::Liquid::Declarations::RemarkItemDrop.new(item)
          end
        end

        def base_item
          ::Expressir::Liquid::ModelElementDrop.new(@model.base_item)
        end
      end
    end
  end
end
