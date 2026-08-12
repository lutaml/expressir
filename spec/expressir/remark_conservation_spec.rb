# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::RemarkConservation do
  describe ".untagged_texts" do
    it "reads a remark that starts a line" do
      expect(described_class.untagged_texts("-- hello\n")).to eq(["hello"])
    end

    it "reads a remark that ends a line of code" do
      expect(described_class.untagged_texts("attr : STRING; -- hello\n"))
        .to eq(["hello"])
    end

    it "leaves out embedded remarks" do
      expect(described_class.untagged_texts("(* hello *)\n")).to be_empty
    end

    it "leaves out an untagged remark with no text" do
      expect(described_class.untagged_texts("--\n")).to be_empty
    end

    it "leaves out tagged remarks" do
      expect(described_class.untagged_texts(%(--"entity.attr" hello\n)))
        .to be_empty
    end

    it "leaves out informal propositions, which the scanner reports tagged" do
      expect(described_class.untagged_texts("  --IP1: holds always\n"))
        .to be_empty
    end
  end

  describe ".tagged_pairs" do
    it "pairs a remark's tag with its text" do
      expect(described_class.tagged_pairs(%(--"entity.attr" hello\n)))
        .to eq([["entity.attr", "hello"]])
    end

    it "leaves out untagged remarks" do
      expect(described_class.tagged_pairs("-- hello\n")).to be_empty
    end

    it "tells apart one text carried under two tags" do
      express = %(--"a" same\n--"b" same\n)

      expect(described_class.tagged_pairs(express))
        .to eq([["a", "same"], ["b", "same"]])
    end

    # A tag may itself contain a colon, so joining tag and text into one
    # string would let these two collide on a single key.
    it "tells apart a colon in the tag from a colon in the text" do
      express = %(--"wr:WR1" holds\n--"wr" WR1: holds\n)

      expect(described_class.tagged_pairs(express))
        .to eq([["wr:WR1", "holds"], ["wr", "WR1: holds"]])
    end

    # A tag with no text still binds to an element, so losing it is a real
    # loss. Dropping it for having no text would hide that behind an empty
    # diff.
    it "keeps a tagged remark that carries no text" do
      expect(described_class.tagged_pairs(%(--"x"\n))).to eq([["x", ""]])
    end

    it "keeps an informal proposition declaration" do
      expect(described_class.tagged_pairs("  --IP1:\n")).to eq([["IP1", ""]])
    end
  end

  describe ".lost" do
    it "reports nothing when both sides match" do
      expect(described_class.lost(%w[a b], %w[b a])).to be_empty
    end

    it "reports a missing text" do
      expect(described_class.lost(%w[a b], %w[a])).to eq({ "b" => 1 })
    end

    it "reports one missing copy of a duplicated text" do
      expect(described_class.lost(%w[a a], %w[a])).to eq({ "a" => 1 })
    end

    it "reports nothing when a text was added" do
      expect(described_class.lost(%w[a], %w[a b])).to be_empty
    end
  end

  describe ".gained" do
    it "reports an added text" do
      expect(described_class.gained(%w[a], %w[a b])).to eq({ "b" => 1 })
    end

    it "reports an added copy of a duplicated text" do
      expect(described_class.gained(%w[a], %w[a a])).to eq({ "a" => 1 })
    end

    it "reports nothing when a text went missing" do
      expect(described_class.gained(%w[a b], %w[a])).to be_empty
    end
  end
end
