module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.5 Compound statement
      class Compound < ModelElement
        attribute :statements, ModelElement, collection: true
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "statements", to: :statements
        end
      end
    end
  end
end
