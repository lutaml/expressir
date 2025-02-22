module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class InterfaceItem < ModelElement
        attribute :ref, ::Expressir::Model::Reference
        attribute :id, :string
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "ref", to: :ref
          map "id", to: :id
        end
      end
    end
  end
end
