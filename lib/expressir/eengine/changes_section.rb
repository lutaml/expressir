# frozen_string_literal: true

require "lutaml/model"
require_relative "modified_object"

module Expressir
  module Eengine
    # Represents a section of changes (modifications, additions, or deletions)
    # in an Eengine comparison report
    class ChangesSection < Lutaml::Model::Serializable
      attribute :modified_objects, ModifiedObject, collection: true

      xml do
        root "changes.section"
        map_element "modified.object", to: :modified_objects
      end
    end
  end
end
