module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.2 Integer literal
      class Integer < ModelElement
        attribute :value, :string
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "value", to: :value
        end
      end
    end
  end
end
