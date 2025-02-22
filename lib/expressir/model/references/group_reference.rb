module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.4 Group references
      class GroupReference < Reference
        attribute :ref, ::Expressir::Model::Reference
        attribute :entity, ::Expressir::Model::Reference
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "ref", to: :ref
          map "entity", to: :entity
        end
      end
    end
  end
end
