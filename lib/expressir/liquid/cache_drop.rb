# frozen_string_literal: true

module Expressir
  module Liquid
    class CacheDrop < ::Expressir::Liquid::ModelElementDrop
      def initialize(model)
        @model = model
        super
      end

      def version
        @model.version
      end

      def content
        ::Expressir::Liquid::ModelElementDrop.new(@model.content)
      end
    end
  end
end
