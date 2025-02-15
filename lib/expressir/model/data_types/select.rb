module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.4.2 Select data type
      class Select < DataType
        attribute :extensible, Expressir::Model::DataTypes::Boolean
        attribute :generic_entity, Expressir::Model::DataTypes::Boolean
        attribute :based_on, ::Expressir::Model::Reference
        attribute :items, ::Expressir::Model::Reference, collection: true
      end
    end
  end
end
