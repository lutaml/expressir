# frozen_string_literal: true

require "lutaml/model"

module Expressir
  class SchemaManifestEntry < Lutaml::Model::Serializable
    attribute :id, Lutaml::Model::Type::String
    attribute :path, Lutaml::Model::Type::String
    # attribute :schemas_only, Lutaml::Model::Type::Boolean

    # container_path is a copy of Expressir::SchemaManifest.path,
    # used to resolve the path of each schema within
    # Expressir::SchemaManifest.schemas,
    # when Expressir::SchemaManifest.schemas is recursively flattened
    attr_accessor :container_path
  end
end
