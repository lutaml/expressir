module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class Interface < ModelElement
        # A remark may trail the clause: `REFERENCE FROM x; -- why`.
        include TakesInlineRemark

        USE = "USE".freeze
        REFERENCE = "REFERENCE".freeze

        attribute :kind, :string, values: %w[USE REFERENCE]
        attribute :schema, ModelElement
        attribute :items, InterfaceItem, collection: true
        attribute :_class, :string, default: -> { self.class.name }

        key_value do
          map "_class", to: :_class, render_default: true
          map "kind", to: :kind
          map "schema", to: :schema
          map "items", to: :items
          # Without this the clause's remark survives a format but not a
          # cache round trip: it would be dropped on serialization and never
          # come back.
          map "untagged_remarks", to: :untagged_remarks
        end
      end
    end
  end
end
