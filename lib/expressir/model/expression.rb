module Expressir
  module Model
    # Specified in ISO 10303-11:2004
    # - section 12 Expression
    # @abstract
    class Expression < ModelElement
      attribute :_class, :string, default: -> { self.send(:name) },
        polymorphic_class: true

      attribute :source, :string

      key_value do
        map "_class", to: :_class, render_default: true,
          polymorphic_map: {
            "Expressir::Model::Expressions::AggregateInitializerItem" => "Expressir::Model::Expressions::AggregateInitializerItem",
            "Expressir::Model::Expressions::AggregateInitializer" => "Expressir::Model::Expressions::AggregateInitializer",
            "Expressir::Model::Expressions::BinaryExpression" => "Expressir::Model::Expressions::BinaryExpression",
            "Expressir::Model::Expressions::EntityConstructor" => "Expressir::Model::Expressions::EntityConstructor",
            "Expressir::Model::Expressions::FunctionCall" => "Expressir::Model::Expressions::FunctionCall",
            "Expressir::Model::Expressions::Interval" => "Expressir::Model::Expressions::Interval",
            "Expressir::Model::Expressions::QueryExpression" => "Expressir::Model::Expressions::QueryExpression",
            "Expressir::Model::Expressions::UnaryExpression" => "Expressir::Model::Expressions::UnaryExpression",
          }
        map "source", to: :source
      end
    end
  end
end
