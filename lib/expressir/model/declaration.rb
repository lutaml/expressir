module Expressir
  module Model
    # Specified in ISO 10303-11:2004
    # - section 9 Declarations
    # @abstract
    class Declaration < ModelElement
      attribute :_class, :string, default: -> { self.send(:name) },
        polymorphic_class: true
      attribute :source, :string

      key_value do
        map "_class", to: :_class, render_default: true,
          polymorphic_map: {
            "Expressir::Model::Declarations::Attribute" => "Expressir::Model::Declarations::Attribute",
            "Expressir::Model::Declarations::Constant" => "Expressir::Model::Declarations::Constant",
            "Expressir::Model::Declarations::Entity" => "Expressir::Model::Declarations::Entity",
            "Expressir::Model::Declarations::Function" => "Expressir::Model::Declarations::Function",
            "Expressir::Model::Declarations::InterfaceItem" => "Expressir::Model::Declarations::InterfaceItem",
            "Expressir::Model::Declarations::Interface" => "Expressir::Model::Declarations::Interface",
            "Expressir::Model::Declarations::InterfacedItem" => "Expressir::Model::Declarations::InterfacedItem",
            "Expressir::Model::Declarations::Parameter" => "Expressir::Model::Declarations::Parameter",
            "Expressir::Model::Declarations::Procedure" => "Expressir::Model::Declarations::Procedure",
            "Expressir::Model::Declarations::RemarkItem" => "Expressir::Model::Declarations::RemarkItem",
            "Expressir::Model::Declarations::Rule" => "Expressir::Model::Declarations::Rule",
            "Expressir::Model::Declarations::SchemaVersionItem" => "Expressir::Model::Declarations::SchemaVersionItem",
            "Expressir::Model::Declarations::SchemaVersion" => "Expressir::Model::Declarations::SchemaVersion",
            "Expressir::Model::Declarations::Schema" => "Expressir::Model::Declarations::Schema",
            "Expressir::Model::Declarations::SubtypeConstraint" => "Expressir::Model::Declarations::SubtypeConstraint",
            "Expressir::Model::Declarations::Type" => "Expressir::Model::Declarations::Type",
            "Expressir::Model::Declarations::UniqueRule" => "Expressir::Model::Declarations::UniqueRule",
            "Expressir::Model::Declarations::Variable" => "Expressir::Model::Declarations::Variable",
            "Expressir::Model::Declarations::WhereRule" => "Expressir::Model::Declarations::WhereRule",
          }
        map "source", to: :source
      end
    end
  end
end
