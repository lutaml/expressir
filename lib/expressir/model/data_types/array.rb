module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.2.1 Array data type
      class Array < DataType
        attribute :bound1, Expressir::Model::Expression
        attribute :bound2, Expressir::Model::Expression
        attribute :optional, Expressir::Model::DataTypes::Boolean
        attribute :unique, Expressir::Model::DataTypes::Boolean
        attribute :base_type, Expressir::Model::DataType
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "bound1", to: :bound1
          map "bound2", to: :bound2
          map "optional", to: :optional
          map "unique", to: :unique
          map "base_type", to: :base_type
        end
      end
    end
  end
end
