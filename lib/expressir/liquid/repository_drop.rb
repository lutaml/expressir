# frozen_string_literal: true

require_relative "declarations/schema_drop"

module Expressir
  module Liquid
    class RepositoryDrop < ::Expressir::Liquid::ModelElementDrop
      def initialize(model)
        @model = model
        super
      end

      def schemas
        return [] unless @model.schemas

        @model.schemas.map do |item|
          ::Expressir::Liquid::Declarations::SchemaDrop.new(item)
        end
      end
    end
  end
end
