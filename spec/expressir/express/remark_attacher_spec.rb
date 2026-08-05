require "spec_helper"

RSpec.describe Expressir::Express::RemarkAttacher do
  describe "#innermost_candidate" do
    let(:attacher) { described_class.new("") }
    let(:parent) { Expressir::Model::Statements::Repeat.new }
    let(:child) { Expressir::Model::Statements::If.new }

    it "prefers the ownership leaf over a smaller-span ancestor" do
      # Node end lines are child-derived approximations: a parent's span can
      # come out SMALLER than its own child's. Span size alone then picks
      # the ancestor. Observed on a production schema, where a comment
      # between END_REPEAT and a nested IF migrated below the enclosing
      # END_IF.
      candidates = [
        { node: parent, line: 10, end_line: 20, owner: nil, collection: nil },
        { node: child, line: 12, end_line: 25, owner: parent,
          collection: :statements },
      ]

      chosen = attacher.send(:innermost_candidate, candidates, candidates)

      expect(chosen[:node]).to be(child)
    end

    it "falls back to smallest span among unrelated candidates" do
      sibling = Expressir::Model::Statements::If.new
      candidates = [
        { node: child, line: 12, end_line: 25, owner: nil,
          collection: :statements },
        { node: sibling, line: 14, end_line: 18, owner: nil,
          collection: :statements },
      ]

      chosen = attacher.send(:innermost_candidate, candidates, candidates)

      expect(chosen[:node]).to be(sibling)
    end

    it "builds the ownership lookup once for an immutable node index" do
      nodes = [
        { node: parent, line: 10, end_line: 20, owner: nil, collection: nil },
        { node: child, line: 12, end_line: 25, owner: parent,
          collection: :statements },
      ]
      expect(nodes).to receive(:to_h).once.and_call_original

      2.times { attacher.send(:innermost_candidate, nodes, nodes) }
    end
  end
end
