module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.2.3 Bag data type
      class Bag < DataType
        attribute :bound1, Expressir::Model::Expression
        attribute :bound2, Expressir::Model::Expression
        attribute :base_type, Expressir::Model::DataType
      end
    end
  end
end
