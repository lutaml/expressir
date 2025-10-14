# frozen_string_literal: true

require "lutaml/model"
require_relative "changes_section"
require_relative "modified_object"

module Expressir
  module Eengine
    # Represents an Eengine MIM comparison XML report
    class MimCompareReport < Lutaml::Model::Serializable
      attribute :modifications, ChangesSection
      attribute :additions, ChangesSection
      attribute :deletions, ChangesSection

      xml do
        root "mim.changes"
        map_element "mim.modifications", to: :modifications
        map_element "mim.additions", to: :additions
        map_element "mim.deletions", to: :deletions
      end

      def mode
        "mim"
      end
    end
  end
end
