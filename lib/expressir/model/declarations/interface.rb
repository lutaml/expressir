module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class Interface < ::Expressir::Model::Declaration
        USE = "USE"
        REFERENCE = "REFERENCE"

        attribute :kind, :string, values: %w[USE REFERENCE]
        attribute :schema, ::Expressir::Model::Reference
        attribute :items, InterfaceItem, collection: true

      end
    end
  end
end
