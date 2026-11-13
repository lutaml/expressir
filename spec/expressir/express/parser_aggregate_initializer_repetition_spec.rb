# frozen_string_literal: true

require "spec_helper"

# #654: an aggregate initializer element keeps its repetition —
# ISO 10303-11:2004 syntax 210 (element) = expression [ ':' repetition ].
# parsanol collapses a single repetition match to a bare hash, which made
# `build_aggregate_initializer` unwrap past the :element tag and dispatch on
# :expression — dropping the AggregateInitializerItem wrapper for exactly the
# one-element-with-repetition shape `[7 : n + 1]`.
RSpec.describe Expressir::Express::Parser, :ruby_lane do
  def parse(source, **options)
    described_class.from_exp(source, **options)
  end

  def return_expression(repo)
    repo.schemas.first.functions.first.statements.first.expression
  end

  %i[ruby native].each do |lane|
    it "keeps the repetition of a single element on the #{lane} engine" do
      use_native = lane == :native
      repo = parse("SCHEMA t;\nFUNCTION f(n : INTEGER) : INTEGER;\nRETURN([7 : n + 1]);\nEND_FUNCTION;\nEND_SCHEMA;\n",
                   use_native: use_native)
      initializer = return_expression(repo)
      item = initializer.items.first

      expect(item).to be_a(Expressir::Model::Expressions::AggregateInitializerItem)
      expect(item.expression).to be_a(Expressir::Model::Literals::Integer)
      expect(item.repetition).to be_a(Expressir::Model::Expressions::BinaryExpression)
      expect(initializer.source).to include(":")
    end

    it "keeps repetitions of both elements on the #{lane} engine" do
      use_native = lane == :native
      repo = parse("SCHEMA t;\nFUNCTION f(n : INTEGER) : INTEGER;\nRETURN([1 : n, 2 : n]);\nEND_FUNCTION;\nEND_SCHEMA;\n",
                   use_native: use_native)
      items = return_expression(repo).items

      expect(items).to all(be_a(Expressir::Model::Expressions::AggregateInitializerItem))
      expect(items.map(&:repetition)).to all(be_truthy)
    end
  end

  it "keeps the repetition of a second element" do
    repo = parse("SCHEMA t;\nFUNCTION f(n : INTEGER) : INTEGER;\nRETURN([1, 2 : n, 3]);\nEND_FUNCTION;\nEND_SCHEMA;\n")
    items = return_expression(repo).items

    expect(items[0]).to be_a(Expressir::Model::Literals::Integer)
    expect(items[1]).to be_a(Expressir::Model::Expressions::AggregateInitializerItem)
    expect(items[2]).to be_a(Expressir::Model::Literals::Integer)
  end

  it "keeps a repetition in the initializer of a local variable" do
    repo = parse("SCHEMA t;\nFUNCTION f(n : INTEGER) : INTEGER;\nLOCAL\nw : LIST [0:?] OF REAL := [1.5 : n];\nEND_LOCAL;\nRETURN(0);\nEND_FUNCTION;\nEND_SCHEMA;\n")
    variable = repo.schemas.first.functions.first.variables.first

    initializer = variable.expression
    expect(initializer.items.first).to be_a(Expressir::Model::Expressions::AggregateInitializerItem)
  end

  it "keeps a repetition in a where-rule comparison" do
    repo = parse("SCHEMA t;\nENTITY e;\nv : INTEGER;\nWHERE\nwr1 : v <> [0 : 3];\nEND_WHERE;\nEND_ENTITY;\nEND_SCHEMA;\n")
    where = repo.schemas.first.entities.first.where_rules.first

    initializer = where.expression.operand2
    expect(initializer.items.first).to be_a(Expressir::Model::Expressions::AggregateInitializerItem)
  end

  it "keeps a repetition in a constant" do
    repo = parse("SCHEMA t;\nCONSTANT\nzeros : LIST [3:3] OF INTEGER := [0 : 3];\nEND_CONSTANT;\nEND_SCHEMA;\n")
    constant = repo.schemas.first.constants.first

    initializer = constant.expression
    expect(initializer.items.first).to be_a(Expressir::Model::Expressions::AggregateInitializerItem)
  end

  it "keeps the inner initializer of a nested repetition" do
    repo = parse("SCHEMA t;\nFUNCTION f(n : INTEGER) : INTEGER;\nRETURN([[1 : n] : n + 1]);\nEND_FUNCTION;\nEND_SCHEMA;\n")
    outer_items = return_expression(repo).items

    expect(outer_items.first).to be_a(Expressir::Model::Expressions::AggregateInitializerItem)
    inner = outer_items.first.expression
    expect(inner.items.first).to be_a(Expressir::Model::Expressions::AggregateInitializerItem)
  end

  it "keeps a bare single element without a repetition plain" do
    repo = parse("SCHEMA t;\nFUNCTION f(n : INTEGER) : INTEGER;\nRETURN([7, n + 1]);\nEND_FUNCTION;\nEND_SCHEMA;\n")
    items = return_expression(repo).items

    expect(items).to all(be_a(Expressir::Model::Literals::Integer).or(be_a(Expressir::Model::Expressions::BinaryExpression)))
  end
end
