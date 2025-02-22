module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.2 Real data type
      class Real < DataType
        attribute :precision, Expressir::Model::Expression
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "precision", to: :precision
        end
      end
    end
  end
end
