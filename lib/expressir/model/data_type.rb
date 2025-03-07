module Expressir
  module Model
    # Specified in ISO 10303-11:2004
    # - section 8 Data types
    # @abstract
    class DataType < ModelElement
      attribute :_class, :string, default: -> { self.send(:name) },
        polymorphic_class: true
      attribute :source, :string

      key_value do
        map "_class", to: :_class, render_default: true,
          polymorphic_map: {
            "Expressir::Model::DataTypes::Aggregate" => "Expressir::Model::DataTypes::Aggregate",
            "Expressir::Model::DataTypes::Array" => "Expressir::Model::DataTypes::Array",
            "Expressir::Model::DataTypes::Bag" => "Expressir::Model::DataTypes::Bag",
            "Expressir::Model::DataTypes::Binary" => "Expressir::Model::DataTypes::Binary",
            "Expressir::Model::DataTypes::Boolean" => "Expressir::Model::DataTypes::Boolean",
            "Expressir::Model::DataTypes::EnumerationItem" => "Expressir::Model::DataTypes::EnumerationItem",
            "Expressir::Model::DataTypes::Enumeration" => "Expressir::Model::DataTypes::Enumeration",
            "Expressir::Model::DataTypes::GenericEntity" => "Expressir::Model::DataTypes::GenericEntity",
            "Expressir::Model::DataTypes::Generic" => "Expressir::Model::DataTypes::Generic",
            "Expressir::Model::DataTypes::Integer" => "Expressir::Model::DataTypes::Integer",
            "Expressir::Model::DataTypes::List" => "Expressir::Model::DataTypes::List",
            "Expressir::Model::DataTypes::Logical" => "Expressir::Model::DataTypes::Logical",
            "Expressir::Model::DataTypes::Number" => "Expressir::Model::DataTypes::Number",
            "Expressir::Model::DataTypes::Real" => "Expressir::Model::DataTypes::Real",
            "Expressir::Model::DataTypes::Select" => "Expressir::Model::DataTypes::Select",
            "Expressir::Model::DataTypes::Set" => "Expressir::Model::DataTypes::Set",
            "Expressir::Model::DataTypes::String" => "Expressir::Model::DataTypes::String",
          }
        map "source", to: :source
      end
    end
  end
end
