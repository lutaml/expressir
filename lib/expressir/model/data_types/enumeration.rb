module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.4.1 Enumeration data type
      class Enumeration < DataType
        attribute :extensible, Expressir::Model::DataTypes::Boolean
        attribute :based_on, ::Expressir::Model::Reference
        attribute :items, Expressir::Model::DataTypes::EnumerationItem, collection: true
     end
    end
  end
end
