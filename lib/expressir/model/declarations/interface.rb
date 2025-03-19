module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class Interface < ModelElement
        USE = "USE".freeze
        REFERENCE = "REFERENCE".freeze

        attribute :kind, :string, values: %w[USE REFERENCE]
        attribute :schema, ModelElement
        attribute :items, InterfaceItem, collection: true
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "kind", to: :kind
          map "schema", to: :schema
          map "items", to: :items
        end
      end
    end
  end
end
