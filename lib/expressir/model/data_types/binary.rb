module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.7 Binary data type
      class Binary < DataType
        attribute :width, Expressir::Model::Expression
        attribute :fixed, Expressir::Model::DataTypes::Boolean
      end
    end
  end
end
