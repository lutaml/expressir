module Expressir
  module Model
    # Specified in ISO 10303-11:2004
    # - section 13 Executable statements
    # @abstract
    class Statement < ModelElement
      attribute :_class, :string, default: -> { self.send(:name) },
        polymorphic_class: true
      attribute :source, :string

      key_value do
        map "_class", to: :_class, render_default: true,
          polymorphic_map: {
            "Expressir::Model::Statements::Alias" => "Expressir::Model::Statements::Alias",
            "Expressir::Model::Statements::Assignment" => "Expressir::Model::Statements::Assignment",
            "Expressir::Model::Statements::CaseAction" => "Expressir::Model::Statements::CaseAction",
            "Expressir::Model::Statements::Case" => "Expressir::Model::Statements::Case",
            "Expressir::Model::Statements::Compound" => "Expressir::Model::Statements::Compound",
            "Expressir::Model::Statements::Escape" => "Expressir::Model::Statements::Escape",
            "Expressir::Model::Statements::If" => "Expressir::Model::Statements::If",
            "Expressir::Model::Statements::Null" => "Expressir::Model::Statements::Null",
            "Expressir::Model::Statements::ProcedureCall" => "Expressir::Model::Statements::ProcedureCall",
            "Expressir::Model::Statements::Repeat" => "Expressir::Model::Statements::Repeat",
            "Expressir::Model::Statements::Return" => "Expressir::Model::Statements::Return",
            "Expressir::Model::Statements::Skip" => "Expressir::Model::Statements::Skip",
          }
        map "source", to: :source
      end
    end
  end
end
