module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.6 String data type
      class String < DataType
        attribute :width, Expressir::Model::Expression
        attribute :fixed, Expressir::Model::DataTypes::Boolean
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "width", to: :width
          map "fixed", to: :fixed
        end
      end
    end
  end
end
