module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class InterfaceItem < ModelElement
        attribute :ref, ::Expressir::Model::Reference
        attribute :id, :string
      end
    end
  end
end
