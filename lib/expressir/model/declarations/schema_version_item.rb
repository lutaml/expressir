module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.3 Schema
      class SchemaVersionItem < ModelElement
        attribute :name, :string
        attribute :value, :string
      end
    end
  end
end
