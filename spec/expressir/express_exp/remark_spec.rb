require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".from_file" do
    it "build an instance from a file" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      schema = repo.schemas.first

      schema.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("universal scope - schema before")
        expect(x.remarks[1]).to eq("universal scope - schema")
      end
      
      schema.constants.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - constant")
        expect(x.remarks[1]).to eq("universal scope - constant")
      end
      
      schema.types.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - type")
        expect(x.remarks[1]).to eq("universal scope - type")
      end
      
      schema.entities.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - entity")
        expect(x.remarks[1]).to eq("universal scope - entity")
      end
      
      schema.entities.first.explicit.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity explicit")
        expect(x.remarks[1]).to eq("schema scope - entity explicit")
        expect(x.remarks[2]).to eq("universal scope - entity explicit")
      end
      
      schema.entities.first.derived.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity derived")
        expect(x.remarks[1]).to eq("schema scope - entity derived")
        expect(x.remarks[2]).to eq("universal scope - entity derived")
      end
      
      schema.entities.first.inverse.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity inverse")
        expect(x.remarks[1]).to eq("schema scope - entity inverse")
        expect(x.remarks[2]).to eq("universal scope - entity inverse")
      end
      
      schema.entities.first.unique.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity unique")
        expect(x.remarks[1]).to eq("schema scope - entity unique")
        expect(x.remarks[2]).to eq("universal scope - entity unique")
      end
      
      schema.entities.first.where.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("entity scope - entity where")
        expect(x.remarks[1]).to eq("schema scope - entity where")
        expect(x.remarks[2]).to eq("universal scope - entity where")
      end
      
      schema.subtype_constraints.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - subtype constraint")
        expect(x.remarks[1]).to eq("universal scope - subtype constraint")
      end
      
      schema.functions.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - function")
        expect(x.remarks[1]).to eq("universal scope - function")
      end
      
      schema.functions.first.parameters.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function parameter")
        expect(x.remarks[1]).to eq("schema scope - function parameter")
        expect(x.remarks[2]).to eq("universal scope - function parameter")
      end
      
      schema.functions.first.types.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function type")
        expect(x.remarks[1]).to eq("schema scope - function type")
        expect(x.remarks[2]).to eq("universal scope - function type")
      end
      
      schema.functions.first.constants.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function constant")
        expect(x.remarks[1]).to eq("schema scope - function constant")
        expect(x.remarks[2]).to eq("universal scope - function constant")
      end
      
      schema.functions.first.locals.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("function scope - function local")
        expect(x.remarks[1]).to eq("schema scope - function local")
        expect(x.remarks[2]).to eq("universal scope - function local")
      end
      
      schema.procedures.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - procedure")
        expect(x.remarks[1]).to eq("universal scope - procedure")
      end
      
      schema.procedures.first.parameters.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure parameter")
        expect(x.remarks[1]).to eq("schema scope - procedure parameter")
        expect(x.remarks[2]).to eq("universal scope - procedure parameter")
      end
      
      schema.procedures.first.types.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure type")
        expect(x.remarks[1]).to eq("schema scope - procedure type")
        expect(x.remarks[2]).to eq("universal scope - procedure type")
      end
      
      schema.procedures.first.constants.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure constant")
        expect(x.remarks[1]).to eq("schema scope - procedure constant")
        expect(x.remarks[2]).to eq("universal scope - procedure constant")
      end
      
      schema.procedures.first.locals.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("procedure scope - procedure local")
        expect(x.remarks[1]).to eq("schema scope - procedure local")
        expect(x.remarks[2]).to eq("universal scope - procedure local")
      end
      
      schema.rules.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(2)
        expect(x.remarks[0]).to eq("schema scope - rule")
        expect(x.remarks[1]).to eq("universal scope - rule")
      end
      
      schema.rules.first.types.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule type")
        expect(x.remarks[1]).to eq("schema scope - rule type")
        expect(x.remarks[2]).to eq("universal scope - rule type")
      end
      
      schema.rules.first.constants.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule constant")
        expect(x.remarks[1]).to eq("schema scope - rule constant")
        expect(x.remarks[2]).to eq("universal scope - rule constant")
      end
      
      schema.rules.first.locals.first.tap do |x|
        expect(x.remarks).to be_instance_of(Array)
        expect(x.remarks.count).to eq(3)
        expect(x.remarks[0]).to eq("rule scope - rule local")
        expect(x.remarks[1]).to eq("schema scope - rule local")
        expect(x.remarks[2]).to eq("universal scope - rule local")
      end
      
      schema.rules.first.where.first.tap do |x|
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
