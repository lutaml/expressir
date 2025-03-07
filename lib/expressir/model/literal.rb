module Expressir
  module Model
    # Specified in ISO 10303-11:2004
    # - section 7.5 Literals
    # @abstract
    class Literal < ModelElement
      attribute :_class, :string, default: -> { self.send(:name) },
        polymorphic_class: true
      attribute :source, :string

      key_value do
        map "_class", to: :_class, render_default: true,
          polymorphic_map: {
            "Expressir::Model::Literals::Binary" => "Expressir::Model::Literals::Binary",
            "Expressir::Model::Literals::Integer" => "Expressir::Model::Literals::Integer",
            "Expressir::Model::Literals::Logical" => "Expressir::Model::Literals::Logical",
            "Expressir::Model::Literals::Real" => "Expressir::Model::Literals::Real",
            "Expressir::Model::Literals::String" => "Expressir::Model::Literals::String",
          }
        map "source", to: :source
      end
    end
  end
end
