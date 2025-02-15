module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.2.4 Set data type
      class Set < DataType
        attribute :bound1, Expressir::Model::Expression
        attribute :bound2, Expressir::Model::Expression
        attribute :base_type, Expressir::Model::DataType

      end
    end
  end
end
