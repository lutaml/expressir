require "spec_helper"
require "expressir/express_exp/parser"

RSpec.describe Expressir::ExpressExp::Parser do
  describe ".from_file" do
    it "build an instance from a file" do
      repo = Expressir::ExpressExp::Parser.from_exp(sample_file)

      schemas = repo.schemas

      schema = schemas.find{|x| x.id == "syntaxSchema"}
      expect(schema.version).to be_instance_of(Expressir::Model::Literals::String)
      expect(schema.version.value).to eq("version")

      interfaces = schema.interfaces
      constants = schema.constants
      types = schema.types
      entities = schema.entities
      subtype_constraints = schema.subtype_constraints
      functions = schema.functions
      procedures = schema.procedures
      rules = schema.rules

      # intefaces
      interfaces.find{|x| x.schema.id == "useInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::USE)
      end

      interfaces.find{|x| x.schema.id == "useItemInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::USE)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].id).to eq("test")
      end

      interfaces.find{|x| x.schema.id == "useItemRenameInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::USE)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::RenamedRef)
        expect(x.items[0].ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].ref.id).to eq("test")
        expect(x.items[0].id).to eq("test2")
      end

      interfaces.find{|x| x.schema.id == "referenceInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::REFERENCE)
      end

      interfaces.find{|x| x.schema.id == "referenceItemInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::REFERENCE)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].id).to eq("test")
      end

      interfaces.find{|x| x.schema.id == "referenceItemRenameInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Interface)
        expect(x.kind).to eq(Expressir::Model::Interface::REFERENCE)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::RenamedRef)
        expect(x.items[0].ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].ref.id).to eq("test")
        expect(x.items[0].id).to eq("test2")
      end

      # literals
      constants.find{|x| x.id == "binaryExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Binary)
        expect(x.value).to eq("011110000111100001111000")
      end

      constants.find{|x| x.id == "integerExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.value).to eq("999")
      end

      constants.find{|x| x.id == "trueLogicalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end
      
      constants.find{|x| x.id == "falseLogicalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      constants.find{|x| x.id == "unknownLogicalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(Expressir::Model::Literals::Logical::UNKNOWN)
      end

      constants.find{|x| x.id == "realExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Real)
        expect(x.value).to eq("999.999")
      end

      constants.find{|x| x.id == "simpleStringExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.value).to eq("xxx")
      end

      constants.find{|x| x.id == "encodedStringExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.value).to eq("000000780000007800000078")
        expect(x.encoded).to eq(true)
      end

      # constants
      constants.find{|x| x.id == "constEExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("CONST_E")
      end

      constants.find{|x| x.id == "indeterminateExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("?")
      end

      constants.find{|x| x.id == "piExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("PI")
      end

      constants.find{|x| x.id == "selfExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("SELF")
      end

      # functions
      constants.find{|x| x.id == "absExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ABS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "acosExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ACOS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "asinExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ASIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "atanExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ATAN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "blengthExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("BLENGTH")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "cosExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("COS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "existsExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("EXISTS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "expExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("EXP")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "formatExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("FORMAT")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "hiboundExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("HIBOUND")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "hiindexExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("HIINDEX")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "lengthExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LENGTH")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "loboundExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOBOUND")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "loindexExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOINDEX")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "logExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOG")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "log2Expression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOG2")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "log10Expression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("LOG10")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "nvlExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("NVL")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "oddExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ODD")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "rolesofExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("ROLESOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "sinExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("SIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "sizeofExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("SIZEOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "sqrtExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("SQRT")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "tanExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("TAN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "typeofExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("TYPEOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "usedinExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("USEDIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "valueExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("VALUE")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "valueInExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("VALUE_IN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "valueUniqueExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("VALUE_UNIQUE")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # operators
      constants.find{|x| x.id == "plusExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::PLUS)
        expect(x.operand).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.value).to eq("4")
      end

      constants.find{|x| x.id == "minusExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::MINUS)
        expect(x.operand).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.value).to eq("4")
      end

      constants.find{|x| x.id == "minusAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::MINUS)
        expect(x.operand).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.operand1.value).to eq("4")
        expect(x.operand.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "additionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "subtractionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "multiplicationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "realDivisionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::REAL_DIVISION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "integerDivisionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::INTEGER_DIVISION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "moduloExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MODULO)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "exponentiationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::EXPONENTIATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "additionAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      constants.find{|x| x.id == "subtractionSubtractionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      constants.find{|x| x.id == "additionSubtractionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      constants.find{|x| x.id == "subtractionAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::SUBTRACTION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("4")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("2")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("1")
      end

      constants.find{|x| x.id == "additionMultiplicationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("8")
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand1.value).to eq("4")
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "multiplicationAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("8")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "parenthesisAdditionMultiplicationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand1.value).to eq("8")
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.operand2.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "multiplicationParenthesisAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::MULTIPLICATION)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("8")
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand1.value).to eq("4")
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "equalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "notEqualExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::NOT_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "instanceEqualExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::INSTANCE_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "instanceNotEqualExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "ltExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "gtExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::GREATER_THAN)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "lteExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "gteExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand1.value).to eq("4")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "notExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::NOT)
        expect(x.operand).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "notOrExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::UnaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::UnaryExpression::NOT)
        expect(x.operand).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      constants.find{|x| x.id == "orExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      constants.find{|x| x.id == "andExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
      end

      constants.find{|x| x.id == "orOrExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "andAndExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "orAndExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand1.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "andOrExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "parenthesisOrAndExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand1.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand1.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.operand2.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "andParenthesisOrExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::OR)
        expect(x.operand2.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand1.value).to eq(Expressir::Model::Literals::Logical::FALSE)
        expect(x.operand2.operand2).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.operand2.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # aggregate initializers
      constants.find{|x| x.id == "aggregateInitializerExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.items[0].value).to eq("xxx")
      end

      constants.find{|x| x.id == "repeatedAggregateInitializerExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::AggregateItem)
        expect(x.items[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.items[0].expression.value).to eq("xxx")
        expect(x.items[0].repetition).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.value).to eq("2")
      end

      constants.find{|x| x.id == "complexAggregateInitializerExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.items[0].operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.items[0].operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].operand1.value).to eq("4")
        expect(x.items[0].operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].operand2.value).to eq("2")
      end

      constants.find{|x| x.id == "complexRepeatedAggregateInitializerExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::AggregateItem)
        expect(x.items[0].expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.items[0].expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.items[0].expression.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].expression.operand1.value).to eq("4")
        expect(x.items[0].expression.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].expression.operand2.value).to eq("2")
        expect(x.items[0].repetition).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.items[0].repetition.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ADDITION)
        expect(x.items[0].repetition.operand1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.operand1.value).to eq("4")
        expect(x.items[0].repetition.operand2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.operand2.value).to eq("2")
      end

      # function call or entity constructor
      constants.find{|x| x.id == "callExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("parameterFunction")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # references
      constants.find{|x| x.id == "simpleReferenceExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.id).to eq("test")
      end

      constants.find{|x| x.id == "attributeReferenceExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("test")
        expect(x.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.attribute.id).to eq("test")
      end

      constants.find{|x| x.id == "groupReferenceExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("test")
        expect(x.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.entity.id).to eq("test")
      end

      constants.find{|x| x.id == "indexReferenceExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("test")
        expect(x.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.index1.value).to eq("1")
      end

      constants.find{|x| x.id == "index2ReferenceExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("test")
        expect(x.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.index1.value).to eq("1")
        expect(x.index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.index2.value).to eq("9")
      end

      # intervals
      constants.find{|x| x.id == "ltLtIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "lteLtIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "ltLteIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "lteLteIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to eq(Expressir::Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "combineExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::COMBINE)
        expect(x.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.operand1.id).to eq("test")
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.operand2.id).to eq("test")
      end

      constants.find{|x| x.id == "inExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::IN)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand1.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.operand2).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.operand2.items).to be_instance_of(Array)
        expect(x.operand2.items.count).to eq(1)
        expect(x.operand2.items[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operand2.items[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      constants.find{|x| x.id == "likeExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.operator).to eq(Expressir::Model::Expressions::BinaryExpression::LIKE)
        expect(x.operand1).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.operand1.value).to eq("xxx")
        expect(x.operand2).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.operand2.value).to eq("xxx")
      end

      # queries
      constants.find{|x| x.id == "queryExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::QueryExpression)
        expect(x.id).to eq("test")
        expect(x.source).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.source.id).to eq("test2")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # types
      types.find{|x| x.id == "emptyType"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Integer)
      end

      types.find{|x| x.id == "whereType"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Integer)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      types.find{|x| x.id == "whereLabelType"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Integer)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].id).to eq("WR1")
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # simple types
      types.find{|x| x.id == "binaryType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Binary)
      end

      types.find{|x| x.id == "binaryWidthType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Binary)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
      end

      types.find{|x| x.id == "binaryWidthFixedType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Binary)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
        expect(x.fixed).to eq(true)
      end

      types.find{|x| x.id == "booleanType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      types.find{|x| x.id == "integerType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Integer)
      end

      types.find{|x| x.id == "logicalType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Logical)
      end

      types.find{|x| x.id == "numberType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Number)
      end

      types.find{|x| x.id == "realType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Real)
      end

      types.find{|x| x.id == "realPrecisionType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Real)
        expect(x.precision).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.precision.value).to eq("3")
      end

      types.find{|x| x.id == "stringType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "stringWidthType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::String)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
      end

      types.find{|x| x.id == "stringWidthFixedType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::String)
        expect(x.width).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.width.value).to eq("3")
        expect(x.fixed).to eq(true)
      end

      # aggregation types
      types.find{|x| x.id == "arrayType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "arrayOptionalType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.optional).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "arrayUniqueType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "arrayOptionalUniqueType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Array)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.optional).to eq(true)
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "bagType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "bagBoundType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "listType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "listBoundType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "listUniqueType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "listBoundUniqueType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::List)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.unique).to eq(true)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "setType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      types.find{|x| x.id == "setBoundType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.base_type).to be_instance_of(Expressir::Model::Types::String)
      end

      # constructed types
      types.find{|x| x.id == "selectType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
      end

      types.find{|x| x.id == "selectExtensibleType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extensible).to eq(true)
      end

      types.find{|x| x.id == "selectExtensibleGenericEntityType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extensible).to eq(true)
        expect(x.generic_entity).to eq(true)
      end

      types.find{|x| x.id == "selectListType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.items[0].id).to eq("emptyType")
      end

      types.find{|x| x.id == "selectExtensionTypeRefType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("selectType")
      end

      types.find{|x| x.id == "selectExtensionTypeRefListType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("selectType")
        expect(x.extension_items).to be_instance_of(Array)
        expect(x.extension_items.count).to eq(1)
        expect(x.extension_items[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_items[0].id).to eq("emptyType")
      end

      types.find{|x| x.id == "enumerationType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
      end

      types.find{|x| x.id == "enumerationExtensibleType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.extensible).to eq(true)
      end

      types.find{|x| x.id == "enumerationListType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::EnumerationItem)
        expect(x.items[0].id).to eq("test")
      end

      types.find{|x| x.id == "enumerationExtensionTypeRefType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("enumerationType")
      end

      types.find{|x| x.id == "enumerationExtensionTypeRefListType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.extension_type.id).to eq("enumerationType")
        expect(x.extension_items).to be_instance_of(Array)
        expect(x.extension_items[0]).to be_instance_of(Expressir::Model::EnumerationItem)
        expect(x.extension_items[0].id).to eq("test")
      end

      # entities
      entities.find{|x| x.id == "emptyEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
      end

      entities.find{|x| x.id == "abstractEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.abstract).to eq(true)
      end

      entities.find{|x| x.id == "abstractSupertypeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.abstract_supertype).to eq(true)
      end

      entities.find{|x| x.id == "abstractSupertypeConstraintEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.abstract_supertype).to eq(true)
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.id).to eq("emptyEntity")
      end

      entities.find{|x| x.id == "supertypeConstraintEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.id).to eq("emptyEntity")
      end

      entities.find{|x| x.id == "subtypeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.supertypes).to be_instance_of(Array)
        expect(x.supertypes.count).to eq(1)
        expect(x.supertypes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertypes[0].id).to eq("emptyEntity")
      end

      entities.find{|x| x.id == "supertypeConstraintSubtypeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.id).to eq("emptyEntity")
        expect(x.supertypes).to be_instance_of(Array)
        expect(x.supertypes.count).to eq(1)
        expect(x.supertypes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.supertypes[0].id).to eq("emptyEntity")
      end

      entities.find{|x| x.id == "explicitAttributeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.explicit).to be_instance_of(Array)
        expect(x.explicit.count).to eq(1)
        expect(x.explicit[0]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[0].id).to eq("test")
        expect(x.explicit[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "explicitAttributeOptionalEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.explicit).to be_instance_of(Array)
        expect(x.explicit.count).to eq(1)
        expect(x.explicit[0]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[0].id).to eq("test")
        expect(x.explicit[0].optional).to eq(true)
        expect(x.explicit[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "explicitAttributeMultipleEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.explicit).to be_instance_of(Array)
        expect(x.explicit.count).to eq(2)
        expect(x.explicit[0]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[0].id).to eq("test")
        expect(x.explicit[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.explicit[1]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[1].id).to eq("test2")
        expect(x.explicit[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "explicitAttributeMultipleShorthandEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.explicit).to be_instance_of(Array)
        expect(x.explicit.count).to eq(2)
        expect(x.explicit[0]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[0].id).to eq("test")
        expect(x.explicit[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.explicit[1]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[1].id).to eq("test2")
        expect(x.explicit[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "explicitAttributeRedeclaredEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.explicit).to be_instance_of(Array)
        expect(x.explicit.count).to eq(1)
        expect(x.explicit[0]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.explicit[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.explicit[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.explicit[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.explicit[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.explicit[0].supertype_attribute.ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.explicit[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.explicit[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.explicit[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "explicitAttributeRedeclaredRenamedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.explicit).to be_instance_of(Array)
        expect(x.explicit.count).to eq(1)
        expect(x.explicit[0]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.explicit[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.explicit[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.explicit[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.explicit[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.explicit[0].supertype_attribute.ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.explicit[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.explicit[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.explicit[0].id).to eq("test2")
        expect(x.explicit[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "derivedAttributeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.derived).to be_instance_of(Array)
        expect(x.derived.count).to eq(1)
        expect(x.derived[0]).to be_instance_of(Expressir::Model::Derived)
        expect(x.derived[0].id).to eq("test")
        expect(x.derived[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.derived[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.derived[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "derivedAttributeRedeclaredEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.derived).to be_instance_of(Array)
        expect(x.derived.count).to eq(1)
        expect(x.derived[0]).to be_instance_of(Expressir::Model::Derived)
        expect(x.derived[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.derived[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.derived[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.derived[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.derived[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.derived[0].supertype_attribute.ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.derived[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.derived[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.derived[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.derived[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.derived[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "derivedAttributeRedeclaredRenamedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.derived).to be_instance_of(Array)
        expect(x.derived.count).to eq(1)
        expect(x.derived[0]).to be_instance_of(Expressir::Model::Derived)
        expect(x.derived[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.derived[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.derived[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.derived[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.derived[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.derived[0].supertype_attribute.ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.derived[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.derived[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.derived[0].id).to eq("test2")
        expect(x.derived[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.derived[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.derived[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "inverseAttributeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeEntityEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.inverse[0].attribute.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.ref.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeSetEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeSetBoundEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.inverse[0].type.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.inverse[0].type.bound1.value).to eq("1")
        expect(x.inverse[0].type.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.inverse[0].type.bound2.value).to eq("9")
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeBagEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeBagBoundEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.inverse[0].type.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.inverse[0].type.bound1.value).to eq("1")
        expect(x.inverse[0].type.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.inverse[0].type.bound2.value).to eq("9")
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeRedeclaredEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.inverse[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.inverse[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.inverse[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].supertype_attribute.ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeRedeclaredRenamedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.inverse[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.inverse[0].supertype_attribute.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].supertype_attribute.ref.ref.id).to eq("SELF")
        expect(x.inverse[0].supertype_attribute.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].supertype_attribute.ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].supertype_attribute.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].supertype_attribute.attribute.id).to eq("test")
        expect(x.inverse[0].id).to eq("test2")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueLabelEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].id).to eq("UR1")
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueQualifiedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.unique[0].attributes[0].ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.unique[0].attributes[0].ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.ref.id).to eq("SELF")
        expect(x.unique[0].attributes[0].ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.unique[0].attributes[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueLabelEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].id).to eq("UR1")
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueLabelQualifiedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].id).to eq("UR1")
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.unique[0].attributes[0].ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.unique[0].attributes[0].ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.ref.id).to eq("SELF")
        expect(x.unique[0].attributes[0].ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].ref.entity.id).to eq("explicitAttributeEntity")
        expect(x.unique[0].attributes[0].attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.unique[0].attributes[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "whereEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      entities.find{|x| x.id == "whereLabelEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].id).to eq("WR1")
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      # subtype constraints
      subtype_constraints.find{|x| x.id == "emptySubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
      end

      subtype_constraints.find{|x| x.id == "abstractSupertypeSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.abstract_supertype).to eq(true)
      end

      subtype_constraints.find{|x| x.id == "totalOverSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.total_over).to be_instance_of(Array)
        expect(x.total_over.count).to eq(1)
        expect(x.total_over[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.total_over[0].id).to eq("a")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.id).to eq("a")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.id).to eq("a")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.id).to eq("a")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionAndorAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.id).to eq("a")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand2.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.operand1.id).to eq("b")
        expect(x.subtype_expression.operand2.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionAndAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand1.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.operand1.id).to eq("a")
        expect(x.subtype_expression.operand1.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.operand2.id).to eq("b")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionParenthesisAndorAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operand1.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand1.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.operand1.id).to eq("a")
        expect(x.subtype_expression.operand1.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.operand2.id).to eq("b")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionAndParenthesisAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.id).to eq("a")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operand2.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand2.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.operand1.id).to eq("b")
        expect(x.subtype_expression.operand2.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.parameters.count).to eq(2)
        expect(x.subtype_expression.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.parameters[0].id).to eq("a")
        expect(x.subtype_expression.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.parameters[1].id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionAndOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.id).to eq("a")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand2.parameters.count).to eq(2)
        expect(x.subtype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[0].id).to eq("b")
        expect(x.subtype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionAndorOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.id).to eq("a")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand2.parameters.count).to eq(2)
        expect(x.subtype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[0].id).to eq("b")
        expect(x.subtype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionOneofAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand1.parameters.count).to eq(2)
        expect(x.subtype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.subtype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionOneofAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand1.parameters.count).to eq(2)
        expect(x.subtype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.subtype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionOneofAndOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::AND)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand1.parameters.count).to eq(2)
        expect(x.subtype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.subtype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand2.parameters.count).to eq(2)
        expect(x.subtype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[0].id).to eq("c")
        expect(x.subtype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[1].id).to eq("d")
      end

      subtype_constraints.find{|x| x.id == "subtypeExpressionOneofAndorOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::BinaryExpression)
        expect(x.subtype_expression.operator).to eq(Expressir::Model::Expressions::BinaryExpression::ANDOR)
        expect(x.subtype_expression.operand1).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand1.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand1.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand1.parameters.count).to eq(2)
        expect(x.subtype_expression.operand1.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[0].id).to eq("a")
        expect(x.subtype_expression.operand1.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand1.parameters[1].id).to eq("b")
        expect(x.subtype_expression.operand2).to be_instance_of(Expressir::Model::Expressions::Call)
        expect(x.subtype_expression.operand2.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.ref.id).to eq("ONEOF")
        expect(x.subtype_expression.operand2.parameters).to be_instance_of(Array)
        expect(x.subtype_expression.operand2.parameters.count).to eq(2)
        expect(x.subtype_expression.operand2.parameters[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[0].id).to eq("c")
        expect(x.subtype_expression.operand2.parameters[1]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.subtype_expression.operand2.parameters[1].id).to eq("d")
      end

      # functions
      functions.find{|x| x.id == "emptyFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "parameterFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multipleParameterFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multipleShorthandParameterFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "typeFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.declarations).to be_instance_of(Array)
        expect(x.declarations.count).to eq(1)
        expect(x.declarations[0]).to be_instance_of(Expressir::Model::Type)
        expect(x.declarations[0].id).to eq("integerType")
        expect(x.declarations[0].type).to be_instance_of(Expressir::Model::Types::Integer)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "constantFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(1)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[0].expression.value).to eq("xxx")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multipleConstantFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(2)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[0].expression.value).to eq("xxx")
        expect(x.constants[1]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[1].id).to eq("test2")
        expect(x.constants[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[1].expression.value).to eq("xxx")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "localFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(1)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multipleLocalFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multipleShorthandLocalFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "localExpressionFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(1)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multipleLocalExpressionFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[1].expression.value).to eq("xxx")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "multipleShorthandLocalExpressionFunction"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Function)
        expect(x.return_type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[1].expression.value).to eq("xxx")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      # procedures
      procedures.find{|x| x.id == "emptyProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
      end

      procedures.find{|x| x.id == "parameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multipleParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].var).not_to eq(true)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multipleShorthandParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].var).not_to eq(true)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "variableParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multipleVariableParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].var).not_to eq(true)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multipleVariableParameter2Procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].var).to eq(true)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "multipleShorthandVariableParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].var).to eq(true)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      procedures.find{|x| x.id == "typeProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.declarations).to be_instance_of(Array)
        expect(x.declarations.count).to eq(1)
        expect(x.declarations[0]).to be_instance_of(Expressir::Model::Type)
        expect(x.declarations[0].id).to eq("integerType")
        expect(x.declarations[0].type).to be_instance_of(Expressir::Model::Types::Integer)
      end

      procedures.find{|x| x.id == "constantProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(1)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[0].expression.value).to eq("xxx")
      end

      procedures.find{|x| x.id == "multipleConstantProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(2)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[0].expression.value).to eq("xxx")
        expect(x.constants[1]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[1].id).to eq("test2")
        expect(x.constants[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[1].expression.value).to eq("xxx")
      end

      procedures.find{|x| x.id == "localProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(1)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
      end

      procedures.find{|x| x.id == "multipleLocalProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
      end

      procedures.find{|x| x.id == "multipleShorthandLocalProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
      end

      procedures.find{|x| x.id == "localExpressionProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(1)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
      end

      procedures.find{|x| x.id == "multipleLocalExpressionProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[1].expression.value).to eq("xxx")
      end

      procedures.find{|x| x.id == "multipleShorthandLocalExpressionProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[1].expression.value).to eq("xxx")
      end

      procedures.find{|x| x.id == "statementProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      # statements
      functions.find{|x| x.id == "aliasSimpleReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasAttributeReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.attribute.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasGroupReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.entity.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasIndexReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.index1.value).to eq("1")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasIndex2ReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.index1.value).to eq("1")
        expect(x.expression.index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.index2.value).to eq("9")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "assignmentSimpleReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignmentAttributeReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::AttributeReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.attribute).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.attribute.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignmentGroupReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::GroupReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.entity).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.entity.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignmentIndexReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.index1.value).to eq("1")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "assignmentIndex2ReferenceStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::IndexReference)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.index1.value).to eq("1")
        expect(x.ref.index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.index2.value).to eq("9")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "caseStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(1)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "caseMultipleStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(2)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.actions[1]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[1].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "caseMultipleShorthandStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(2)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.actions[1]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[1].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[1].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "caseOtherwiseStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.expression.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(1)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.otherwise_statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "compoundStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Compound)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "escapeStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Escape)
      end

      functions.find{|x| x.id == "ifStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(2)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "ifElseStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(1)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if2ElseStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(2)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(1)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "ifElse2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(2)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if2Else2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(2)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements).to be_instance_of(Array)
        expect(x.else_statements.count).to eq(2)
        expect(x.else_statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.else_statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "nullStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "callStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("emptyProcedure")
      end

      functions.find{|x| x.id == "callParameterStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("emptyProcedure")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "callParameter2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("emptyProcedure")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[1].value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "callInsertStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("INSERT")
      end

      functions.find{|x| x.id == "callRemoveStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Call)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.ref.id).to eq("REMOVE")
      end

      functions.find{|x| x.id == "repeatStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeatVariableStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.id).to eq("test")
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeatVariableIncrementStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.id).to eq("test")
        expect(x.bound1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound1.value).to eq("1")
        expect(x.bound2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.bound2.value).to eq("9")
        expect(x.increment).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.increment.value).to eq("2")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeatWhileStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.while_expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.while_expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeatUntilStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.until_expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.until_expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "returnStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Return)
      end

      functions.find{|x| x.id == "returnExpressionStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Return)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      functions.find{|x| x.id == "skipStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Skip)
      end

      # rules
      rules.find{|x| x.id == "emptyRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "typeRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.declarations).to be_instance_of(Array)
        expect(x.declarations.count).to eq(1)
        expect(x.declarations[0]).to be_instance_of(Expressir::Model::Type)
        expect(x.declarations[0].id).to eq("integerType")
        expect(x.declarations[0].type).to be_instance_of(Expressir::Model::Types::Integer)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "constantRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(1)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[0].expression.value).to eq("xxx")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multipleConstantRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.constants).to be_instance_of(Array)
        expect(x.constants.count).to eq(2)
        expect(x.constants[0]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[0].id).to eq("test")
        expect(x.constants[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[0].expression.value).to eq("xxx")
        expect(x.constants[1]).to be_instance_of(Expressir::Model::Constant)
        expect(x.constants[1].id).to eq("test2")
        expect(x.constants[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.constants[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.constants[1].expression.value).to eq("xxx")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "localRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(1)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multipleLocalRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multipleShorthandLocalRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "localExpressionRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(1)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multipleLocalExpressionRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[1].expression.value).to eq("xxx")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "multipleShorthandLocalExpressionRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.locals).to be_instance_of(Array)
        expect(x.locals.count).to eq(2)
        expect(x.locals[0]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[0].id).to eq("test")
        expect(x.locals[0].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[0].expression.value).to eq("xxx")
        expect(x.locals[1]).to be_instance_of(Expressir::Model::Local)
        expect(x.locals[1].id).to eq("test2")
        expect(x.locals[1].type).to be_instance_of(Expressir::Model::Types::String)
        expect(x.locals[1].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.locals[1].expression.value).to eq("xxx")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end

      rules.find{|x| x.id == "statementRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Expressions::SimpleReference)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(Expressir::Model::Literals::Logical::TRUE)
      end
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "syntax.exp"
    )
  end
end