# frozen_string_literal: true

require "lutaml/model"

module Expressir
  module Eengine
    # Represents a modified EXPRESS object in an Eengine comparison report
    class ModifiedObject < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :name, :string
      attribute :interfaced_items, :string
      attribute :description, :string

      xml do
        root "modified.object"
        map_attribute "type", to: :type
        map_attribute "name", to: :name
        map_attribute "interfaced.items", to: :interfaced_items
        map_element "description", to: :description
      end
    end
  end
end
