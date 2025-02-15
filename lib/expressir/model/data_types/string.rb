module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.6 String data type
      class String < DataType
        attribute :width, Expressir::Model::Expression
        attribute :fixed, Expressir::Model::DataTypes::Boolean
      end
    end
  end
end
