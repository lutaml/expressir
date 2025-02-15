module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.2.2 List data type
      class List < DataType
        attribute :bound1, Expressir::Model::Expression
        attribute :bound2, Expressir::Model::Expression
        attribute :unique, Expressir::Model::DataTypes::Boolean
        attribute :base_type, Expressir::Model::DataType

      end
    end
  end
end
