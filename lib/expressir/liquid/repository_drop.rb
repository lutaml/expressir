# frozen_string_literal: true

require_relative "declarations/schema_drop"

module Expressir
  module Liquid
    class RepositoryDrop < ::Expressir::Liquid::ModelElementDrop
      def initialize(model, selected_schemas: nil, options: {}) # rubocop:disable Lint/MissingSuper
        @model = model
        @selected_schemas = selected_schemas
        @options = options
        super
      end

      def schemas
        return [] unless @model.schemas

        @model.schemas.map do |item|
          ::Expressir::Liquid::Declarations::SchemaDrop.new(
            item,
            selected_schemas: @selected_schemas,
            options: @options,
          )
        end
      end
    end
  end
end
