module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class SchemaVersion < ModelElement
        attribute :value, :string
        attribute :items, SchemaVersionItem, collection: true
      end
    end
  end
end
