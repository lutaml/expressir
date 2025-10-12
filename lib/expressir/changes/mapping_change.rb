# frozen_string_literal: true

require "lutaml/model"

module Expressir
  module Changes
    # Represents a mapping change entry
    class MappingChange < Lutaml::Model::Serializable
      attribute :change, :string
      attribute :description, :string

      yaml do
        map "change", to: :change
        map "description", to: :description
      end
    end
  end
end
