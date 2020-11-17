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
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("universal scope - schema before")
        expect(x.remarks[1]).to eq("universal scope - schema")
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
      end
      
      schema.entities.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - entity")
        expect(x.remarks[1]).to eq("universal scope - entity")
      end
      
      schema.entities.first.explicit.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Explicit)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity explicit")
        expect(x.remarks[1]).to eq("schema scope - entity explicit")
        expect(x.remarks[2]).to eq("universal scope - entity explicit")
      end
      
      schema.entities.first.derived.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Derived)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity derived")
        expect(x.remarks[1]).to eq("schema scope - entity derived")
        expect(x.remarks[2]).to eq("universal scope - entity derived")
      end
      
      schema.entities.first.inverse.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Inverse)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity inverse")
        expect(x.remarks[1]).to eq("schema scope - entity inverse")
        expect(x.remarks[2]).to eq("universal scope - entity inverse")
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
      end
      
      schema.functions.first.constants.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function constant")
        expect(x.remarks[1]).to eq("schema scope - function constant")
        expect(x.remarks[2]).to eq("universal scope - function constant")
      end
      
      schema.functions.first.locals.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Local)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function local")
        expect(x.remarks[1]).to eq("schema scope - function local")
        expect(x.remarks[2]).to eq("universal scope - function local")
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
      end
      
      schema.procedures.first.constants.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure constant")
        expect(x.remarks[1]).to eq("schema scope - procedure constant")
        expect(x.remarks[2]).to eq("universal scope - procedure constant")
      end
      
      schema.procedures.first.locals.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Local)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure local")
        expect(x.remarks[1]).to eq("schema scope - procedure local")
        expect(x.remarks[2]).to eq("universal scope - procedure local")
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
      end
      
      schema.rules.first.constants.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Constant)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule constant")
        expect(x.remarks[1]).to eq("schema scope - rule constant")
        expect(x.remarks[2]).to eq("universal scope - rule constant")
      end
      
      schema.rules.first.locals.first.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Local)
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule local")
        expect(x.remarks[1]).to eq("schema scope - rule local")
        expect(x.remarks[2]).to eq("universal scope - rule local")
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
