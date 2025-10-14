# frozen_string_literal: true

require "lutaml/model"
require_relative "changes_section"
require_relative "modified_object"

module Expressir
  module Eengine
    # Represents an Eengine ARM comparison XML report
    class ArmCompareReport < Lutaml::Model::Serializable
      attribute :modifications, ChangesSection
      attribute :additions, ChangesSection
      attribute :deletions, ChangesSection

      xml do
        root "arm.changes"
        map_element "arm.modifications", to: :modifications
        map_element "arm.additions", to: :additions
        map_element "arm.deletions", to: :deletions
      end

      def mode
        "arm"
      end
    end
  end
end
