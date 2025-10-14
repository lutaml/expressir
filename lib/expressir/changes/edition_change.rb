# frozen_string_literal: true

require "lutaml/model"
require_relative "item_change"
require_relative "mapping_change"

module Expressir
  module Changes
    # Represents a version edition of schema changes
    class EditionChange < Lutaml::Model::Serializable
      attribute :version, :string
      attribute :description, :string
      attribute :additions, ItemChange, collection: true
      attribute :modifications, ItemChange, collection: true
      attribute :deletions, ItemChange, collection: true
      attribute :mappings, MappingChange, collection: true
      attribute :changes, MappingChange, collection: true

      yaml do
        map "version", to: :version
        map "description", to: :description
        map "additions", to: :additions
        map "modifications", to: :modifications
        map "deletions", to: :deletions
        map "mappings", to: :mappings
        map "changes", to: :changes
      end
    end
  end
end
