require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".from_file" do
    it "build an instance from a file" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      schema = repo.schemas.first

      schema.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Schema)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(5)
        expect(x.remarks[0]).to eq("Any character within the EXPRESS character set may occur between the start and end of\nan embedded remark including the newline character; therefore, embedded remarks can span\nseveral physical lines.")
        expect(x.remarks[1]).to eq("The tail remark is written at the end of a physical line.")
        expect(x.remarks[2]).to eq("UTF8 test: Příliš žluťoučký kůň úpěl ďábelské ódy.")
        expect(x.remarks[3]).to eq("universal scope - schema before")
        expect(x.remarks[4]).to eq("universal scope - schema")
      end
      
      schema.constants.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - constant")
        expect(x.remarks[1]).to eq("universal scope - constant")
      end
      
      schema.types.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - type")
        expect(x.remarks[1]).to eq("universal scope - type")

        expect(x.type).to be_instance_of(Expressir::Model::Types::Enumeration)
        x.type.items.first.tap do |x|
          expect(x).to be_instance_of(Expressir::Model::EnumerationItem)
          expect(x.remarks).to be_instance_of(Array)
          expect(x.remarks.count).to eq(2)
          expect(x.remarks[0]).to eq("schema scope - enumeration item")
          expect(x.remarks[1]).to eq("universal scope - enumeration item")
        end
      end
      
      schema.entities.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - entity")
        expect(x.remarks[1]).to eq("universal scope - entity")
      end
      
      schema.entities.first.explicit_attributes.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Attribute)
        expect(x.kind).to eq(Expressir::Model::Attribute::EXPLICIT)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity attribute")
        expect(x.remarks[1]).to eq("schema scope - entity attribute")
        expect(x.remarks[2]).to eq("universal scope - entity attribute")
      end
      
      schema.entities.first.derived_attributes.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Attribute)
        expect(x.kind).to eq(Expressir::Model::Attribute::DERIVED)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity derived attribute")
        expect(x.remarks[1]).to eq("schema scope - entity derived attribute")
        expect(x.remarks[2]).to eq("universal scope - entity derived attribute")
      end
      
      schema.entities.first.inverse_attributes.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Attribute)
        expect(x.kind).to eq(Expressir::Model::Attribute::INVERSE)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity inverse attribute")
        expect(x.remarks[1]).to eq("schema scope - entity inverse attribute")
        expect(x.remarks[2]).to eq("universal scope - entity inverse attribute")
      end
      
      schema.entities.first.unique.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Unique)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity unique")
        expect(x.remarks[1]).to eq("schema scope - entity unique")
        expect(x.remarks[2]).to eq("universal scope - entity unique")
      end
      
      schema.entities.first.where.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Where)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity where")
        expect(x.remarks[1]).to eq("schema scope - entity where")
        expect(x.remarks[2]).to eq("universal scope - entity where")
      end
      
      schema.subtype_constraints.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - subtype constraint")
        expect(x.remarks[1]).to eq("universal scope - subtype constraint")
      end
      
      schema.functions.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - function")
        expect(x.remarks[1]).to eq("universal scope - function")
      end
      
      schema.functions.first.parameters.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Parameter)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function parameter")
        expect(x.remarks[1]).to eq("schema scope - function parameter")
        expect(x.remarks[2]).to eq("universal scope - function parameter")
      end
      
      schema.functions.first.types.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function type")
        expect(x.remarks[1]).to eq("schema scope - function type")
        expect(x.remarks[2]).to eq("universal scope - function type")

        expect(x.type).to be_instance_of(Expressir::Model::Types::Enumeration)
        x.type.items.first.tap do |x|
          expect(x).to be_instance_of(Expressir::Model::EnumerationItem)
          expect(x.remarks).to be_instance_of(Array)
          expect(x.remarks.count).to eq(3)
          expect(x.remarks[0]).to eq("function scope - function enumeration item")
          expect(x.remarks[1]).to eq("schema scope - function enumeration item")
          expect(x.remarks[2]).to eq("universal scope - function enumeration item")
        end
      end
      
      schema.functions.first.constants.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function constant")
        expect(x.remarks[1]).to eq("schema scope - function constant")
        expect(x.remarks[2]).to eq("universal scope - function constant")
      end
      
      schema.functions.first.variables.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Variable)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function variable")
        expect(x.remarks[1]).to eq("schema scope - function variable")
        expect(x.remarks[2]).to eq("universal scope - function variable")
      end
      
      schema.functions.first.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(1)
        expect(x.remarks[0]).to eq("function alias scope - function alias")
      end
      
      schema.functions.first.statements[1].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(1)
        expect(x.remarks[0]).to eq("function repeat scope - function repeat")
      end
      
      schema.functions.first.statements[2].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::QueryExpression)
        expect(x.expression.remarks).to be_instance_of(Array)
        expect(x.expression.remarks.count).to eq(1)
        expect(x.expression.remarks[0]).to eq("function query scope - function query")
      end
      
      schema.procedures.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - procedure")
        expect(x.remarks[1]).to eq("universal scope - procedure")
      end
      
      schema.procedures.first.parameters.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Parameter)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure parameter")
        expect(x.remarks[1]).to eq("schema scope - procedure parameter")
        expect(x.remarks[2]).to eq("universal scope - procedure parameter")
      end
      
      schema.procedures.first.types.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure type")
        expect(x.remarks[1]).to eq("schema scope - procedure type")
        expect(x.remarks[2]).to eq("universal scope - procedure type")

        expect(x.type).to be_instance_of(Expressir::Model::Types::Enumeration)
        x.type.items.first.tap do |x|
          expect(x).to be_instance_of(Expressir::Model::EnumerationItem)
          expect(x.remarks).to be_instance_of(Array)
          expect(x.remarks.count).to eq(3)
          expect(x.remarks[0]).to eq("procedure scope - procedure enumeration item")
          expect(x.remarks[1]).to eq("schema scope - procedure enumeration item")
          expect(x.remarks[2]).to eq("universal scope - procedure enumeration item")
        end
      end
      
      schema.procedures.first.constants.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure constant")
        expect(x.remarks[1]).to eq("schema scope - procedure constant")
        expect(x.remarks[2]).to eq("universal scope - procedure constant")
      end
      
      schema.procedures.first.variables.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Variable)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure variable")
        expect(x.remarks[1]).to eq("schema scope - procedure variable")
        expect(x.remarks[2]).to eq("universal scope - procedure variable")
      end
      
      schema.procedures.first.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(1)
        expect(x.remarks[0]).to eq("procedure alias scope - procedure alias")
      end
      
      schema.procedures.first.statements[1].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(1)
        expect(x.remarks[0]).to eq("procedure repeat scope - procedure repeat")
      end
      
      schema.procedures.first.statements[2].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::QueryExpression)
        expect(x.expression.remarks).to be_instance_of(Array)
        expect(x.expression.remarks.count).to eq(1)
        expect(x.expression.remarks[0]).to eq("procedure query scope - procedure query")
      end
      
      schema.rules.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - rule")
        expect(x.remarks[1]).to eq("universal scope - rule")
      end
      
      schema.rules.first.types.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule type")
        expect(x.remarks[1]).to eq("schema scope - rule type")
        expect(x.remarks[2]).to eq("universal scope - rule type")

        expect(x.type).to be_instance_of(Expressir::Model::Types::Enumeration)
        x.type.items.first.tap do |x|
          expect(x).to be_instance_of(Expressir::Model::EnumerationItem)
          expect(x.remarks).to be_instance_of(Array)
          expect(x.remarks.count).to eq(3)
          expect(x.remarks[0]).to eq("rule scope - rule enumeration item")
          expect(x.remarks[1]).to eq("schema scope - rule enumeration item")
          expect(x.remarks[2]).to eq("universal scope - rule enumeration item")
        end
      end
      
      schema.rules.first.constants.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule constant")
        expect(x.remarks[1]).to eq("schema scope - rule constant")
        expect(x.remarks[2]).to eq("universal scope - rule constant")
      end
      
      schema.rules.first.variables.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Variable)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule variable")
        expect(x.remarks[1]).to eq("schema scope - rule variable")
        expect(x.remarks[2]).to eq("universal scope - rule variable")
      end
      
      schema.rules.first.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(1)
        expect(x.remarks[0]).to eq("rule alias scope - rule alias")
      end
      
      schema.rules.first.statements[1].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(1)
        expect(x.remarks[0]).to eq("rule repeat scope - rule repeat")
      end
      
      schema.rules.first.statements[2].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::QueryExpression)
        expect(x.expression.remarks).to be_instance_of(Array)
        expect(x.expression.remarks.count).to eq(1)
        expect(x.expression.remarks[0]).to eq("rule query scope - rule query")
      end
      
      schema.rules.first.where.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Where)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule where")
        expect(x.remarks[1]).to eq("schema scope - rule where")
        expect(x.remarks[2]).to eq("universal scope - rule where")
      end
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "remark.exp"
    )
  end
end
