# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# expressir#609, two re-attachment defects the production-scale probe
# surfaced, both fixed here and pinned so neither comes back silently.
#
# 1. A `(*"s.f.lv"` remark block sitting INSIDE function f created the
#    item with the schema's id: the attacher's Strategy 3 prepends the
#    containing scope's path to the tag, double-counting a tag that is
#    already absolute, and the implicit walk then names the item after
#    the first unresolved segment — the schema.
#
# 2. A function's end_line is pushed past its END_FUNCTION line when its
#    remark items live between declarations (their spans follow the
#    END line). The end-window in NodePositionIndex#node_for_end_scope_at
#    then misses, and the old fallback handed every unresolvable
#    END_FUNCTION tail to the FIRST function of the schema —
#    mathematical_functions_schema piled 19 other functions' tails onto
#    all_members_of_es. Containment resolves those; nothing falls back to
#    a first-of-type node any more.
RSpec.describe Expressir::Express::RemarkAttacher do
  describe "absolute tags inside a scope" do
    let(:source) do
      <<~EXPRESS
        SCHEMA demo_schema;
        FUNCTION f : INTEGER;
        (*"demo_schema.f.lv"

        the lv remark

        *)
        RETURN(1);
        END_FUNCTION;
        END_SCHEMA;
      EXPRESS
    end

    it "creates the item with the tag's leaf id (core lane)" do
      model = Expressir::Express::Parser.from_file(
        write_temp_schema(source), annotations: false
      )
      item = model.schemas[0].functions[0].remark_items[0]
      expect(item.id).to eq("lv")
      expect(item.parent.id).to eq("f")
    end

    it "creates the item with the tag's leaf id (grammar lane)" do
      model = Expressir::Express::Parser.from_exp(source, use_native: false)
      item = model.schemas[0].functions[0].remark_items[0]
      expect(item.id).to eq("lv")
    end

    it "round trips the item's id" do
      model = Expressir::Express::Parser.from_file(write_temp_schema(source))
      reparsed = Expressir::Express::Parser.from_exp(model.to_s)
      item = reparsed.schemas[0].functions[0].remark_items[0]
      expect(item.id).to eq("lv")
    end
  end

  describe "function tails with item blocks between declarations" do
    let(:source) do
      <<~EXPRESS
        SCHEMA demo_schema;
        FUNCTION a : INTEGER;
          RETURN (1);
        END_FUNCTION;  -- a

        (*"demo_schema.a.p" the a item *)

        FUNCTION b : INTEGER;
          RETURN (2);
        END_FUNCTION;  -- b
        END_SCHEMA;
      EXPRESS
    end

    it "attaches each tail to its own function, not the first" do
      model = Expressir::Express::Parser.from_file(write_temp_schema(source))
      tails = model.schemas[0].functions.to_h do |f|
        [f.id, Array(f.untagged_remarks).map { |r| r.respond_to?(:text) ? r.text : r.to_s }]
      end
      expect(tails["a"]).to eq(["a"])
      expect(tails["b"]).to eq(["b"])
    end

    it "keeps the index resolving END_FUNCTION tails by containment" do
      file = write_temp_schema(source)
      model = Expressir::Express::Parser.from_file(file)
      file_source = File.read(file)
      line_map = Expressir::Express::LineMap.new(file_source.b)
      index = Expressir::Express::NodePositionIndex.new(model, line_map)
      b_fn = model.schemas[0].functions[1]
      b_tail_line = file_source.lines.index { |l| l.include?("END_FUNCTION;  -- b") } + 1
      resolved = index.node_for_end_scope_at(b_tail_line, "END_FUNCTION;  -- b")
      expect(resolved).to equal(b_fn)
    end
  end

  def write_temp_schema(source)
    file = File.join(Dir.mktmpdir, "spec609.exp")
    File.write(file, source)
    file
  end
end
