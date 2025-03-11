module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.3 Real literal
      class Real < ModelElement
        attribute :value, :string
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "value", to: :value
        end
      end
    end
  end
end
