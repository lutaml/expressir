# frozen_string_literal: true

require_relative "declarations/remark_item_drop"

module Expressir
  module Liquid
    module IdentifierDrop
      def initialize_identifier(model)
        @model = model
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

      def source
        @model.source
      end
    end
  end
end
