module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.3 Attribute references
      class AttributeReference < Reference
        attribute :ref, ::Expressir::Model::Reference
        attribute :attribute, ::Expressir::Model::Reference
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "ref", to: :ref
          map "attribute", to: :attribute
        end
      end
    end
  end
end
