module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.4.1 Enumeration data type
      class Enumeration < ModelElement
        attribute :extensible, :boolean
        attribute :based_on, ModelElement
        attribute :items, EnumerationItem, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "extensible", to: :extensible
          map "based_on", to: :based_on
          map "items", to: :items
        end
      end
    end
  end
end
