# frozen_string_literal: true

require_relative "declarations/schema_drop"

module Expressir
  module Liquid
    class RepositoryDrop < ::Expressir::Liquid::ModelElementDrop
      def initialize(model, options: {}) # rubocop:disable Lint/MissingSuper
        @model = model
        @options = options
        super(model)
      end

      def schemas
        return [] unless @model.schemas

        @model.schemas.map do |item|
          ::Expressir::Liquid::Declarations::SchemaDrop.new(
            item, options: @options
          )
        end
      end
    end
  end
end
