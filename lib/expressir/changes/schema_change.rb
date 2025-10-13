# frozen_string_literal: true

require "lutaml/model"
require_relative "edition_change"

module Expressir
  module Changes
    # Represents changes to an EXPRESS schema across multiple versions
    class SchemaChange < Lutaml::Model::Serializable
      attribute :schema, :string
      attribute :editions, EditionChange, collection: true

      yaml do
        map "schema", to: :schema
        map "editions", to: :editions
      end

      class << self
        # Load a SchemaChange from a YAML file
        #
        # @param path [String] Path to the YAML file
        # @return [SchemaChange] The loaded schema changes
        def from_file(path)
          content = File.read(path)
          # Handle empty or minimal YAML files
          return new if content.strip == "---" || content.strip.empty?

          from_yaml(content)
        end
      end

      # Add or update a change edition in this schema
      #
      # @param version [String] Version number
      # @param description [String] Description of changes
      # @param changes [Hash] Hash with :additions, :modifications, :removals
      # @return [EditionChange] The added or updated edition
      def add_or_update_edition(version, description, changes)
        version_str = version.to_s

        # Initialize editions array if nil
        self.editions ||= []

        # Find existing edition with this version
        existing_index = editions.find_index do |ed|
          ed.version == version_str
        end

        # Create new edition
        edition = EditionChange.new(
          version: version_str,
          description: description,
          additions: changes[:additions] || [],
          modifications: changes[:modifications] || [],
          removals: changes[:removals] || [],
          deletions: changes[:deletions] || [],
        )

        if existing_index
          # Replace existing edition with same version
          editions[existing_index] = edition
        else
          # Add new edition
          editions << edition
        end

        edition
      end

      # Save this SchemaChange to a YAML file
      #
      # @param path [String] Path where to save the file
      # @return [Integer] Number of bytes written
      def to_file(path)
        File.write(path, to_yaml)
      end
    end
  end
end
