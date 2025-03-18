module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 9.2.6 Implicit declarations
      class EntityConstructor < ModelElement
        attribute :entity, ModelElement
        attribute :parameters, ModelElement, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "entity", to: :entity
          map "parameters", to: :parameters
        end
      end
    end
  end
end
