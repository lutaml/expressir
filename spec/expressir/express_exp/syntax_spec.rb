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
        expect(x).to be_instance_of(Expressir::Model::Use)
      end

      interfaces.find{|x| x.schema.id == "useItemInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Use)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.items[0].id).to eq("test")
      end

      interfaces.find{|x| x.schema.id == "useItemRenameInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Use)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::RenamedRef)
        expect(x.items[0].ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.items[0].ref.id).to eq("test")
        expect(x.items[0].id).to eq("test2")
      end

      interfaces.find{|x| x.schema.id == "referenceInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Reference)
      end

      interfaces.find{|x| x.schema.id == "referenceItemInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Reference)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.items[0].id).to eq("test")
      end

      interfaces.find{|x| x.schema.id == "referenceItemRenameInterface"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Reference)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::RenamedRef)
        expect(x.items[0].ref).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.value).to eq(true)
      end
      
      constants.find{|x| x.id == "falseLogicalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(false)
      end

      constants.find{|x| x.id == "unknownLogicalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.value).to eq(nil)
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
        expect(x).to be_instance_of(Expressir::Model::Ref)
        expect(x.id).to eq("CONST_E")
      end

      constants.find{|x| x.id == "indeterminateExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Ref)
        expect(x.id).to eq("?")
      end

      constants.find{|x| x.id == "piExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Ref)
        expect(x.id).to eq("PI")
      end

      constants.find{|x| x.id == "selfExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Ref)
        expect(x.id).to eq("SELF")
      end

      # functions
      constants.find{|x| x.id == "absExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("ABS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "acosExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("ACOS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "asinExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("ASIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "atanExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("ATAN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "blengthExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("BLENGTH")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "cosExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("COS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "existsExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("EXISTS")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "expExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("EXP")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "formatExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("FORMAT")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "hiboundExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("HIBOUND")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "hiindexExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("HIINDEX")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "lengthExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("LENGTH")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "loboundExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("LOBOUND")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "loindexExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("LOINDEX")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "logExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("LOG")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "log2Expression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("LOG2")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "log10Expression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("LOG10")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "nvlExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("NVL")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "oddExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("ODD")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "rolesofExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("ROLESOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "sinExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("SIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "sizeofExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("SIZEOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "sqrtExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("SQRT")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "tanExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("TAN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "typeofExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("TYPEOF")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "usedinExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("USEDIN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "valueExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("VALUE")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "valueInExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("VALUE_IN")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      constants.find{|x| x.id == "valueUniqueExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::FunctionCall)
        expect(x.function).to be_instance_of(Expressir::Model::Ref)
        expect(x.function.id).to eq("VALUE_UNIQUE")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      # operations
      constants.find{|x| x.id == "unaryPlusExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::UnaryPlus)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(1)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
      end

      constants.find{|x| x.id == "unaryMinusExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::UnaryMinus)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(1)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
      end

      constants.find{|x| x.id == "additionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "subtractionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Subtraction)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "multiplicationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Multiplication)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "realDivisionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::RealDivision)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "integerDivisionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::IntegerDivision)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "moduloExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Modulo)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "exponentiationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Exponentiation)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "additionAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[0].value).to eq("4")
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[1].value).to eq("2")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("1")
      end

      constants.find{|x| x.id == "subtractionSubtractionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Subtraction)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Subtraction)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[0].value).to eq("4")
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[1].value).to eq("2")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("1")
      end

      constants.find{|x| x.id == "additionSubtractionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Subtraction)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[0].value).to eq("4")
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[1].value).to eq("2")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("1")
      end

      constants.find{|x| x.id == "subtractionAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Subtraction)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[0].value).to eq("4")
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[1].value).to eq("2")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("1")
      end

      constants.find{|x| x.id == "additionMultiplicationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("8")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Multiplication)
        expect(x.operands[1].operands).to be_instance_of(Array)
        expect(x.operands[1].operands.count).to eq(2)
        expect(x.operands[1].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].operands[0].value).to eq("4")
        expect(x.operands[1].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "multiplicationAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Multiplication)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[0].value).to eq("8")
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[1].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "parenthesisAdditionMultiplicationExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Multiplication)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[0].value).to eq("8")
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].operands[1].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "multiplicationParenthesisAdditionExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Multiplication)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("8")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.operands[1].operands).to be_instance_of(Array)
        expect(x.operands[1].operands.count).to eq(2)
        expect(x.operands[1].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].operands[0].value).to eq("4")
        expect(x.operands[1].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "equalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Equal)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "notEqualExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::NotEqual)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "ltExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::LessThan)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "gtExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::GreaterThan)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "lteExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::LessThanOrEqual)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "gteExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::GreaterThanOrEqual)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[0].value).to eq("4")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "orExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Or)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].value).to eq(true)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].value).to eq(false)
      end

      constants.find{|x| x.id == "andExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].value).to eq(true)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].value).to eq(false)
      end

      constants.find{|x| x.id == "orOrExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Or)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Or)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[0].value).to eq(true)
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[1].value).to eq(false)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].value).to eq(true)
      end

      constants.find{|x| x.id == "andAndExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[0].value).to eq(true)
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[1].value).to eq(false)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].value).to eq(true)
      end

      constants.find{|x| x.id == "orAndExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Or)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].value).to eq(true)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[1].operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.operands[1].operands).to be_instance_of(Array)
        expect(x.operands[1].operands.count).to eq(2)
        expect(x.operands[1].operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].operands[0].value).to eq(false)
        expect(x.operands[1].operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].operands[1].value).to eq(true)
      end

      constants.find{|x| x.id == "andOrExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Or)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[0].value).to eq(true)
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[1].value).to eq(false)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].value).to eq(true)
      end

      constants.find{|x| x.id == "parenthesisOrAndExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Or)
        expect(x.operands[0].operands).to be_instance_of(Array)
        expect(x.operands[0].operands.count).to eq(2)
        expect(x.operands[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[0].value).to eq(true)
        expect(x.operands[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].operands[1].value).to eq(false)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].value).to eq(true)
      end

      constants.find{|x| x.id == "andParenthesisOrExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].value).to eq(true)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Or)
        expect(x.operands[1].operands).to be_instance_of(Array)
        expect(x.operands[1].operands.count).to eq(2)
        expect(x.operands[1].operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].operands[0].value).to eq(false)
        expect(x.operands[1].operands[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].operands[1].value).to eq(true)
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
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::AggregateElement)
        expect(x.items[0].expression).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.items[0].expression.value).to eq("xxx")
        expect(x.items[0].repetition).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.value).to eq("2")
      end

      constants.find{|x| x.id == "complexAggregateInitializerExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.items[0].operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.items[0].operands).to be_instance_of(Array)
        expect(x.items[0].operands.count).to eq(2)
        expect(x.items[0].operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].operands[0].value).to eq("4")
        expect(x.items[0].operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].operands[1].value).to eq("2")
      end

      constants.find{|x| x.id == "complexRepeatedAggregateInitializerExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.items).to be_instance_of(Array)
        expect(x.items.count).to eq(1)
        expect(x.items[0]).to be_instance_of(Expressir::Model::Expressions::AggregateElement)
        expect(x.items[0].expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.items[0].expression.operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.items[0].expression.operands).to be_instance_of(Array)
        expect(x.items[0].expression.operands.count).to eq(2)
        expect(x.items[0].expression.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].expression.operands[0].value).to eq("4")
        expect(x.items[0].expression.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].expression.operands[1].value).to eq("2")
        expect(x.items[0].repetition).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.items[0].repetition.operator).to be_instance_of(Expressir::Model::Operators::Addition)
        expect(x.items[0].repetition.operands).to be_instance_of(Array)
        expect(x.items[0].repetition.operands.count).to eq(2)
        expect(x.items[0].repetition.operands[0]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.operands[0].value).to eq("4")
        expect(x.items[0].repetition.operands[1]).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.items[0].repetition.operands[1].value).to eq("2")
      end

      # entity constructors
      constants.find{|x| x.id == "entityConstructorExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::EntityConstructor)
        expect(x.entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.entity.id).to eq("explicitAttributeEntity")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      # enumeration references
      constants.find{|x| x.id == "enumerationReferenceExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Ref)
        expect(x.id).to eq("test")
      end

      constants.find{|x| x.id == "attributeEnumerationReferenceExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.id).to eq("test")
        expect(x.qualifiers).to be_instance_of(Array)
        expect(x.qualifiers.count).to eq(1)
        expect(x.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.qualifiers[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.qualifiers[0].attribute.id).to eq("test")
      end

      # intervals
      constants.find{|x| x.id == "ltLtIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to be_instance_of(Expressir::Model::Operators::LessThan)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to be_instance_of(Expressir::Model::Operators::LessThan)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "lteLtIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to be_instance_of(Expressir::Model::Operators::LessThanOrEqual)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to be_instance_of(Expressir::Model::Operators::LessThan)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "ltLteIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to be_instance_of(Expressir::Model::Operators::LessThan)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to be_instance_of(Expressir::Model::Operators::LessThanOrEqual)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "lteLteIntervalExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Interval)
        expect(x.low).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.low.value).to eq("1")
        expect(x.operator1).to be_instance_of(Expressir::Model::Operators::LessThanOrEqual)
        expect(x.item).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.item.value).to eq("5")
        expect(x.operator2).to be_instance_of(Expressir::Model::Operators::LessThanOrEqual)
        expect(x.high).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.high.value).to eq("9")
      end

      constants.find{|x| x.id == "combineExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Combine)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.operands[0].id).to eq("test")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.operands[1].id).to eq("test")
      end

      constants.find{|x| x.id == "inExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::In)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[0].value).to eq(true)
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Expressions::AggregateInitializer)
        expect(x.operands[1].items).to be_instance_of(Array)
        expect(x.operands[1].items.count).to eq(1)
        expect(x.operands[1].items[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.operands[1].items[0].value).to eq(true)
      end

      constants.find{|x| x.id == "likeExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.operator).to be_instance_of(Expressir::Model::Operators::Like)
        expect(x.operands).to be_instance_of(Array)
        expect(x.operands.count).to eq(2)
        expect(x.operands[0]).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.operands[0].value).to eq("xxx")
        expect(x.operands[1]).to be_instance_of(Expressir::Model::Literals::String)
        expect(x.operands[1].value).to eq("xxx")
      end

      # queries
      constants.find{|x| x.id == "queryExpression"}.expression.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Expressions::Query)
        expect(x.id).to eq("test")
        expect(x.source).to be_instance_of(Expressir::Model::Ref)
        expect(x.source.id).to eq("test2")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
      end

      # types
      types.find{|x| x.id == "integerType"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Integer)
      end

      types.find{|x| x.id == "integerWhereType"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Integer)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(true)
      end

      types.find{|x| x.id == "integerWhereLabelType"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Type)
        expect(x.type).to be_instance_of(Expressir::Model::Types::Integer)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].id).to eq("WR1")
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(true)
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
        expect(x.items[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.items[0].id).to eq("test")
      end

      types.find{|x| x.id == "selectExtensionTypeRefType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Ref)
        expect(x.extension_type.id).to eq("selectType")
      end

      types.find{|x| x.id == "selectExtensionTypeRefListType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Select)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Ref)
        expect(x.extension_type.id).to eq("selectType")
        expect(x.extension_items).to be_instance_of(Array)
        expect(x.extension_items.count).to eq(1)
        expect(x.extension_items[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.extension_items[0].id).to eq("test")
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
        expect(x.extension_type).to be_instance_of(Expressir::Model::Ref)
        expect(x.extension_type.id).to eq("enumerationType")
      end

      types.find{|x| x.id == "enumerationExtensionTypeRefListType"}.type.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Types::Enumeration)
        expect(x.extension_type).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.id).to eq("emptyEntity")
      end

      entities.find{|x| x.id == "supertypeConstraintEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.id).to eq("emptyEntity")
      end

      entities.find{|x| x.id == "subtypeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.supertypes).to be_instance_of(Array)
        expect(x.supertypes.count).to eq(1)
        expect(x.supertypes[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.supertypes[0].id).to eq("emptyEntity")
      end

      entities.find{|x| x.id == "supertypeConstraintSubtypeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.id).to eq("emptyEntity")
        expect(x.supertypes).to be_instance_of(Array)
        expect(x.supertypes.count).to eq(1)
        expect(x.supertypes[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.explicit[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.explicit[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.explicit[0].supertype_attribute.ref.id).to eq("SELF")
        expect(x.explicit[0].supertype_attribute.qualifiers).to be_instance_of(Array)
        expect(x.explicit[0].supertype_attribute.qualifiers.count).to eq(2)
        expect(x.explicit[0].supertype_attribute.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.explicit[0].supertype_attribute.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.explicit[0].supertype_attribute.qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.explicit[0].supertype_attribute.qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.explicit[0].supertype_attribute.qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.explicit[0].supertype_attribute.qualifiers[1].attribute.id).to eq("test")
        expect(x.explicit[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
      end

      entities.find{|x| x.id == "explicitAttributeRedeclaredRenamedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.explicit).to be_instance_of(Array)
        expect(x.explicit.count).to eq(1)
        expect(x.explicit[0]).to be_instance_of(Expressir::Model::Explicit)
        expect(x.explicit[0].id).to eq("test2")
        expect(x.explicit[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.explicit[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.explicit[0].supertype_attribute.ref.id).to eq("SELF")
        expect(x.explicit[0].supertype_attribute.qualifiers).to be_instance_of(Array)
        expect(x.explicit[0].supertype_attribute.qualifiers.count).to eq(2)
        expect(x.explicit[0].supertype_attribute.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.explicit[0].supertype_attribute.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.explicit[0].supertype_attribute.qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.explicit[0].supertype_attribute.qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.explicit[0].supertype_attribute.qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.explicit[0].supertype_attribute.qualifiers[1].attribute.id).to eq("test")
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
        expect(x.derived[0].expression.value).to eq(true)
      end

      entities.find{|x| x.id == "derivedAttributeRedeclaredEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.derived).to be_instance_of(Array)
        expect(x.derived.count).to eq(1)
        expect(x.derived[0]).to be_instance_of(Expressir::Model::Derived)
        expect(x.derived[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.derived[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.derived[0].supertype_attribute.ref.id).to eq("SELF")
        expect(x.derived[0].supertype_attribute.qualifiers).to be_instance_of(Array)
        expect(x.derived[0].supertype_attribute.qualifiers.count).to eq(2)
        expect(x.derived[0].supertype_attribute.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.derived[0].supertype_attribute.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.derived[0].supertype_attribute.qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.derived[0].supertype_attribute.qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.derived[0].supertype_attribute.qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.derived[0].supertype_attribute.qualifiers[1].attribute.id).to eq("test")
        expect(x.derived[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.derived[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.derived[0].expression.value).to eq(true)
      end

      entities.find{|x| x.id == "derivedAttributeRedeclaredRenamedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.derived).to be_instance_of(Array)
        expect(x.derived.count).to eq(1)
        expect(x.derived[0]).to be_instance_of(Expressir::Model::Derived)
        expect(x.derived[0].id).to eq("test2")
        expect(x.derived[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.derived[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.derived[0].supertype_attribute.ref.id).to eq("SELF")
        expect(x.derived[0].supertype_attribute.qualifiers).to be_instance_of(Array)
        expect(x.derived[0].supertype_attribute.qualifiers.count).to eq(2)
        expect(x.derived[0].supertype_attribute.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.derived[0].supertype_attribute.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.derived[0].supertype_attribute.qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.derived[0].supertype_attribute.qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.derived[0].supertype_attribute.qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.derived[0].supertype_attribute.qualifiers[1].attribute.id).to eq("test")
        expect(x.derived[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.derived[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.derived[0].expression.value).to eq(true)
      end

      entities.find{|x| x.id == "inverseAttributeEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeEntityEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.inverse[0].attribute.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].attribute.ref.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute.qualifiers).to be_instance_of(Array)
        expect(x.inverse[0].attribute.qualifiers.count).to eq(1)
        expect(x.inverse[0].attribute.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.inverse[0].attribute.qualifiers[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].attribute.qualifiers[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeSetEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Types::Set)
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeBagEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Types::Bag)
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.inverse[0].type.base_type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.base_type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeRedeclaredEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.inverse[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].supertype_attribute.ref.id).to eq("SELF")
        expect(x.inverse[0].supertype_attribute.qualifiers).to be_instance_of(Array)
        expect(x.inverse[0].supertype_attribute.qualifiers.count).to eq(2)
        expect(x.inverse[0].supertype_attribute.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.inverse[0].supertype_attribute.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].supertype_attribute.qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].supertype_attribute.qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.inverse[0].supertype_attribute.qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].supertype_attribute.qualifiers[1].attribute.id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "inverseAttributeRedeclaredRenamedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.inverse).to be_instance_of(Array)
        expect(x.inverse.count).to eq(1)
        expect(x.inverse[0]).to be_instance_of(Expressir::Model::Inverse)
        expect(x.inverse[0].id).to eq("test2")
        expect(x.inverse[0].supertype_attribute).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.inverse[0].supertype_attribute.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].supertype_attribute.ref.id).to eq("SELF")
        expect(x.inverse[0].supertype_attribute.qualifiers).to be_instance_of(Array)
        expect(x.inverse[0].supertype_attribute.qualifiers.count).to eq(2)
        expect(x.inverse[0].supertype_attribute.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.inverse[0].supertype_attribute.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].supertype_attribute.qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].supertype_attribute.qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.inverse[0].supertype_attribute.qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].supertype_attribute.qualifiers[1].attribute.id).to eq("test")
        expect(x.inverse[0].type).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].type.id).to eq("explicitAttributeEntity")
        expect(x.inverse[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.inverse[0].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.unique[0].attributes[0].id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueQualifiedEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.unique[0].attributes[0].ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.unique[0].attributes[0].ref.id).to eq("SELF")
        expect(x.unique[0].attributes[0].qualifiers).to be_instance_of(Array)
        expect(x.unique[0].attributes[0].qualifiers.count).to eq(2)
        expect(x.unique[0].attributes[0].qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.unique[0].attributes[0].qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.unique[0].attributes[0].qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.unique[0].attributes[0].qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.unique[0].attributes[0].qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.unique[0].attributes[0].qualifiers[1].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "uniqueLabelEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.unique).to be_instance_of(Array)
        expect(x.unique.count).to eq(1)
        expect(x.unique[0]).to be_instance_of(Expressir::Model::Unique)
        expect(x.unique[0].id).to eq("UR1")
        expect(x.unique[0].attributes).to be_instance_of(Array)
        expect(x.unique[0].attributes.count).to eq(1)
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.unique[0].attributes[0]).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.unique[0].attributes[0].ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.unique[0].attributes[0].ref.id).to eq("SELF")
        expect(x.unique[0].attributes[0].qualifiers).to be_instance_of(Array)
        expect(x.unique[0].attributes[0].qualifiers.count).to eq(2)
        expect(x.unique[0].attributes[0].qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.unique[0].attributes[0].qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.unique[0].attributes[0].qualifiers[0].entity.id).to eq("explicitAttributeEntity")
        expect(x.unique[0].attributes[0].qualifiers[1]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.unique[0].attributes[0].qualifiers[1].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.unique[0].attributes[0].qualifiers[1].attribute.id).to eq("test")
      end

      entities.find{|x| x.id == "whereEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(true)
      end

      entities.find{|x| x.id == "whereLabelEntity"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Entity)
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].id).to eq("WR1")
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(true)
      end

      # subtype constraints
      subtype_constraints.find{|x| x.id == "emptySubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
      end

      subtype_constraints.find{|x| x.id == "abstractSupertypeSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.abstract_supertype).to eq(true)
      end

      subtype_constraints.find{|x| x.id == "totalOverSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.total_over).to be_instance_of(Array)
        expect(x.total_over.count).to eq(1)
        expect(x.total_over[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.total_over[0].id).to eq("a")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.id).to eq("a")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionAndorAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[1].operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands[1].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[1].operands.count).to eq(2)
        expect(x.subtype_expression.operands[1].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[0].id).to eq("b")
        expect(x.subtype_expression.operands[1].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionAndAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[0].operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands[0].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[0].operands.count).to eq(2)
        expect(x.subtype_expression.operands[0].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[0].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[1].id).to eq("b")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionParenthesisAndorAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands[0].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[0].operands.count).to eq(2)
        expect(x.subtype_expression.operands[0].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[0].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[1].id).to eq("b")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionAndParenthesisAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands[1].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[1].operands.count).to eq(2)
        expect(x.subtype_expression.operands[1].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[0].id).to eq("b")
        expect(x.subtype_expression.operands[1].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].id).to eq("b")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionAndOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[1].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[1].operands.count).to eq(2)
        expect(x.subtype_expression.operands[1].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[0].id).to eq("b")
        expect(x.subtype_expression.operands[1].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionAndorOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[1].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[1].operands.count).to eq(2)
        expect(x.subtype_expression.operands[1].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[0].id).to eq("b")
        expect(x.subtype_expression.operands[1].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionOneofAndSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[0].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[0].operands.count).to eq(2)
        expect(x.subtype_expression.operands[0].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[0].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[1].id).to eq("b")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionOneofAndorSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[0].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[0].operands.count).to eq(2)
        expect(x.subtype_expression.operands[0].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[0].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[1].id).to eq("b")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].id).to eq("c")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionOneofAndOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::And)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[0].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[0].operands.count).to eq(2)
        expect(x.subtype_expression.operands[0].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[0].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[1].id).to eq("b")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[1].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[1].operands.count).to eq(2)
        expect(x.subtype_expression.operands[1].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[0].id).to eq("c")
        expect(x.subtype_expression.operands[1].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[1].id).to eq("d")
      end

      subtype_constraints.find{|x| x.id == "supertypeExpressionOneofAndorOneofSubtypeConstraint"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::SubtypeConstraint)
        expect(x.applies_to).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to.id).to eq("emptyEntity")
        expect(x.subtype_expression).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operator).to be_instance_of(Expressir::Model::Operators::Andor)
        expect(x.subtype_expression.operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands.count).to eq(2)
        expect(x.subtype_expression.operands[0]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[0].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[0].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[0].operands.count).to eq(2)
        expect(x.subtype_expression.operands[0].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[0].id).to eq("a")
        expect(x.subtype_expression.operands[0].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[0].operands[1].id).to eq("b")
        expect(x.subtype_expression.operands[1]).to be_instance_of(Expressir::Model::Expressions::Expression)
        expect(x.subtype_expression.operands[1].operator).to be_instance_of(Expressir::Model::Operators::Oneof)
        expect(x.subtype_expression.operands[1].operands).to be_instance_of(Array)
        expect(x.subtype_expression.operands[1].operands.count).to eq(2)
        expect(x.subtype_expression.operands[1].operands[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[0].id).to eq("c")
        expect(x.subtype_expression.operands[1].operands[1]).to be_instance_of(Expressir::Model::Ref)
        expect(x.subtype_expression.operands[1].operands[1].id).to eq("d")
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
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[0].var).not_to eq(true)
      end

      procedures.find{|x| x.id == "multipleParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1].var).not_to eq(true)
      end

      procedures.find{|x| x.id == "multipleShorthandParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1].var).not_to eq(true)
      end

      procedures.find{|x| x.id == "variableParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[0].var).to eq(true)
      end

      procedures.find{|x| x.id == "multipleVariableParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1].var).not_to eq(true)
      end

      procedures.find{|x| x.id == "multipleVariableParameter2Procedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[0].var).not_to eq(true)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1].var).to eq(true)
      end

      procedures.find{|x| x.id == "multipleShorthandVariableParameterProcedure"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Procedure)
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[0].id).to eq("test")
        expect(x.parameters[0].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[0].var).to eq(true)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Parameter)
        expect(x.parameters[1].id).to eq("test2")
        expect(x.parameters[1].type).to be_instance_of(Expressir::Model::Types::Boolean)
        expect(x.parameters[1].var).to eq(true)
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

      # rules
      rules.find{|x| x.id == "emptyRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
        expect(x.applies_to[0].id).to eq("emptyEntity")
        expect(x.where).to be_instance_of(Array)
        expect(x.where.count).to eq(1)
        expect(x.where[0]).to be_instance_of(Expressir::Model::Where)
        expect(x.where[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "typeRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "constantRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "multipleConstantRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "localRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "multipleLocalRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "multipleShorthandLocalRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "localExpressionRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "multipleLocalExpressionRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      rules.find{|x| x.id == "multipleShorthandLocalExpressionRule"}.tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Rule)
        expect(x.applies_to).to be_instance_of(Array)
        expect(x.applies_to.count).to eq(1)
        expect(x.applies_to[0]).to be_instance_of(Expressir::Model::Ref)
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
        expect(x.where[0].expression.value).to eq(true)
      end

      # statements
      functions.find{|x| x.id == "aliasStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Ref)
        expect(x.expression.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasAttributeStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.qualifiers).to be_instance_of(Array)
        expect(x.expression.qualifiers.count).to eq(1)
        expect(x.expression.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.expression.qualifiers[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.expression.qualifiers[0].attribute.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasGroupStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.qualifiers).to be_instance_of(Array)
        expect(x.expression.qualifiers.count).to eq(1)
        expect(x.expression.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.expression.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.expression.qualifiers[0].entity.id).to eq("test")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasIndexStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.qualifiers).to be_instance_of(Array)
        expect(x.expression.qualifiers.count).to eq(1)
        expect(x.expression.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::IndexQualifier)
        expect(x.expression.qualifiers[0].index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.qualifiers[0].index1.value).to eq("1")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "aliasIndex2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Alias)
        expect(x.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.expression.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.expression.ref.id).to eq("test")
        expect(x.expression.qualifiers).to be_instance_of(Array)
        expect(x.expression.qualifiers.count).to eq(1)
        expect(x.expression.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::IndexQualifier)
        expect(x.expression.qualifiers[0].index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.qualifiers[0].index1.value).to eq("1")
        expect(x.expression.qualifiers[0].index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.expression.qualifiers[0].index2.value).to eq("9")
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "assignmentStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
      end

      functions.find{|x| x.id == "assignmentAttributeStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.qualifiers).to be_instance_of(Array)
        expect(x.ref.qualifiers.count).to eq(1)
        expect(x.ref.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::AttributeQualifier)
        expect(x.ref.qualifiers[0].attribute).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.qualifiers[0].attribute.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
      end

      functions.find{|x| x.id == "assignmentGroupStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.qualifiers).to be_instance_of(Array)
        expect(x.ref.qualifiers.count).to eq(1)
        expect(x.ref.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::GroupQualifier)
        expect(x.ref.qualifiers[0].entity).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.qualifiers[0].entity.id).to eq("test")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
      end

      functions.find{|x| x.id == "assignmentIndexStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.qualifiers).to be_instance_of(Array)
        expect(x.ref.qualifiers.count).to eq(1)
        expect(x.ref.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::IndexQualifier)
        expect(x.ref.qualifiers[0].index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.qualifiers[0].index1.value).to eq("1")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
      end

      functions.find{|x| x.id == "assignmentIndex2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Assignment)
        expect(x.ref).to be_instance_of(Expressir::Model::Expressions::QualifiedRef)
        expect(x.ref.ref).to be_instance_of(Expressir::Model::Ref)
        expect(x.ref.ref.id).to eq("test")
        expect(x.ref.qualifiers).to be_instance_of(Array)
        expect(x.ref.qualifiers.count).to eq(1)
        expect(x.ref.qualifiers[0]).to be_instance_of(Expressir::Model::Expressions::IndexQualifier)
        expect(x.ref.qualifiers[0].index1).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.qualifiers[0].index1.value).to eq("1")
        expect(x.ref.qualifiers[0].index2).to be_instance_of(Expressir::Model::Literals::Integer)
        expect(x.ref.qualifiers[0].index2.value).to eq("9")
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
      end

      functions.find{|x| x.id == "caseStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.selector).to be_instance_of(Expressir::Model::Ref)
        expect(x.selector.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(1)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(true)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "caseMultipleStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.selector).to be_instance_of(Expressir::Model::Ref)
        expect(x.selector.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(2)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(true)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.actions[1]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[1].expression.value).to eq(true)
        expect(x.actions[1].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "caseMultipleShorthandStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.selector).to be_instance_of(Expressir::Model::Ref)
        expect(x.selector.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(2)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(true)
        expect(x.actions[0].statement).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.actions[1]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[1].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[1].expression.value).to eq(true)
        expect(x.actions[1].statement).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "caseOtherwiseStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Case)
        expect(x.selector).to be_instance_of(Expressir::Model::Ref)
        expect(x.selector.id).to eq("test")
        expect(x.actions).to be_instance_of(Array)
        expect(x.actions.count).to eq(1)
        expect(x.actions[0]).to be_instance_of(Expressir::Model::Statements::CaseAction)
        expect(x.actions[0].expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.actions[0].expression.value).to eq(true)
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
        expect(x.expression.value).to eq(true)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "if2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(2)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
        expect(x.statements[1]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "ifElseStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::If)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
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
        expect(x.expression.value).to eq(true)
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
        expect(x.expression.value).to eq(true)
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
        expect(x.expression.value).to eq(true)
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

      functions.find{|x| x.id == "procedureCallStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::ProcedureCall)
        expect(x.procedure).to be_instance_of(Expressir::Model::Ref)
        expect(x.procedure.id).to eq("emptyProcedure")
      end

      functions.find{|x| x.id == "procedureCallParameterStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::ProcedureCall)
        expect(x.procedure).to be_instance_of(Expressir::Model::Ref)
        expect(x.procedure.id).to eq("emptyProcedure")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(1)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
      end

      functions.find{|x| x.id == "procedureCallParameter2Statement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::ProcedureCall)
        expect(x.procedure).to be_instance_of(Expressir::Model::Ref)
        expect(x.procedure.id).to eq("emptyProcedure")
        expect(x.parameters).to be_instance_of(Array)
        expect(x.parameters.count).to eq(2)
        expect(x.parameters[0]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[0].value).to eq(true)
        expect(x.parameters[1]).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.parameters[1].value).to eq(true)
      end

      functions.find{|x| x.id == "procedureCallInsertStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::ProcedureCall)
        expect(x.procedure).to be_instance_of(Expressir::Model::Ref)
        expect(x.procedure.id).to eq("INSERT")
      end

      functions.find{|x| x.id == "procedureCallRemoveStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::ProcedureCall)
        expect(x.procedure).to be_instance_of(Expressir::Model::Ref)
        expect(x.procedure.id).to eq("REMOVE")
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
        expect(x.while_expression.value).to eq(true)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "repeatUntilStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Repeat)
        expect(x.until_expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.until_expression.value).to eq(true)
        expect(x.statements).to be_instance_of(Array)
        expect(x.statements.count).to eq(1)
        expect(x.statements[0]).to be_instance_of(Expressir::Model::Statements::Null)
      end

      functions.find{|x| x.id == "returnStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Return)
        expect(x.expression).to be_instance_of(Expressir::Model::Literals::Logical)
        expect(x.expression.value).to eq(true)
      end

      functions.find{|x| x.id == "skipStatement"}.statements[0].tap do |x|
        expect(x).to be_instance_of(Expressir::Model::Statements::Skip)
      end
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "syntax", "syntax.exp"
    )
  end
end
