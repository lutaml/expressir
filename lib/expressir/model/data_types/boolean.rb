module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.5 Boolean data type
      class Boolean < ModelElement
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
        end
      end
    end
  end
end
