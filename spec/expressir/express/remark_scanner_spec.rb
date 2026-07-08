require "spec_helper"

RSpec.describe Expressir::Express::RemarkScanner do
  def scan(source)
    described_class.new(source).scan
  end

  describe "#scan" do
    context "with `--` inside a `(* ... *)` block (issue #308)" do
      let(:source) do
        <<~EXP
          SCHEMA mini_schema;
          (*
          This schema provides representations for items a) -- d). that are mandatory in any application.

          [NOTE]
          --
          Scenarios of the expected use are described in the introduction.
          --
          *)
          END_SCHEMA;
        EXP
      end

      it "extracts only the embedded remark" do
        expect(scan(source).map { |r| r[:format] }).to eq(["embedded"])
      end

      it "keeps the inline `--` prose inside the embedded remark text" do
        remark = scan(source).first

        expect(remark[:text]).to include("items a) -- d).")
        expect(remark[:text]).to include("[NOTE]\n--\nScenarios")
      end
    end

    it "extracts a tail remark following `*)` on the same line" do
      remarks = scan("SCHEMA test;\n(* block *) -- tail after block\nEND_SCHEMA;\n")

      tails = remarks.select { |r| r[:format] == "tail" }
      expect(tails.map { |r| r[:text] }).to eq(["tail after block"])
    end

    it "does not extract a tail remark from a single-line block remark" do
      remarks = scan("SCHEMA test;\n(* prose -- more prose *)\nEND_SCHEMA;\n")

      expect(remarks.map { |r| r[:format] }).to eq(["embedded"])
    end

    it "extracts nothing from inside an unterminated block remark" do
      expect(scan("SCHEMA test;\n(* never closed\n-- not a tail\n")).to be_empty
    end

    it "consumes a `(*` opened inside a tail remark with its line" do
      remarks = scan(
        "a : INTEGER; -- see (* note\nb : INTEGER; -- other\n(* real *)\n",
      )

      expect(remarks.map { |r| [r[:format], r[:text]] }).to eq(
        [["tail", "see (* note"], ["tail", "other"], ["embedded", "real"]],
      )
    end

    it "extracts a plain tail remark with position and line" do
      source = "SCHEMA test;\n-- a tail remark\nEND_SCHEMA;\n"
      remark = scan(source).first

      expect(remark).to eq(
        position: source.index("--"),
        line: 2,
        text: "a tail remark",
        tag: nil,
        format: "tail",
      )
    end

    it "parses tagged tail remarks" do
      remark = scan("--\"tag1\" This is a tagged remark\n").first

      expect(remark[:tag]).to eq("tag1")
      expect(remark[:text]).to eq("This is a tagged remark")
    end

    it "parses informal proposition tail remarks" do
      remark = scan("--IP1: proposition text\n").first

      expect(remark[:tag]).to eq("IP1")
      expect(remark[:text]).to eq("proposition text")
    end

    it "parses tagged embedded remarks" do
      remark = scan("(*\"schema.entity\" documentation *)\n").first

      expect(remark[:tag]).to eq("schema.entity")
      expect(remark[:text]).to eq("documentation")
    end

    it "records embedded remark position and line at the opening `(*`" do
      source = "SCHEMA test;\n\n(* doc\nspans lines *)\n-- tail\n"
      embedded, tail = scan(source)

      expect(embedded[:position]).to eq(source.index("(*"))
      expect(embedded[:line]).to eq(3)
      expect(tail[:line]).to eq(5)
    end

    it "preserves multibyte remark text with byte positions" do
      source = "name : STRING; -- Name in Japanese: 名前\n"
      remark = scan(source).first

      expect(remark[:text]).to eq("Name in Japanese: 名前")
      expect(remark[:position]).to eq(source.b.index("--"))
    end

    it "returns remarks ordered by byte position" do
      source = "-- one\n(* two *)\n-- three\n"

      expect(scan(source).map { |r| [r[:position], r[:format]] }).to eq(
        [[0, "tail"], [7, "embedded"], [17, "tail"]],
      )
    end

    it "returns no remarks for source without any" do
      expect(scan("SCHEMA test;\nEND_SCHEMA;\n")).to be_empty
    end
  end
end
