require "spec_helper"

RSpec.describe Expressir::Express::Visitor::RemarkAttacher do
  describe "integration tests with real parsing" do
    let(:exp_file) { Expressir.root_path.join("spec", "fixtures", "validate_ascii", "non_ascii_in_remarks_only.exp") }
    let(:repo) { Expressir::Express::Parser.from_file(exp_file) }
    let(:schema) { repo.schemas.first }
    let(:entity) { schema.entities.first }

    it "preserves tail remarks on entity attributes" do
      expect(entity.id).to eq("person")

      # Name attribute should have its tail remark
      name_attr = entity.attributes.find { |a| a.id == "name" }
      expect(name_attr).not_to be_nil

      # Check that untagged_remarks contains a RemarkInfo with the expected text
      name_remark_texts = name_attr.untagged_remarks.map do |r|
        r.is_a?(Expressir::Model::RemarkInfo) ? r.text : r
      end
      expect(name_remark_texts).to include("Name in Japanese: 名前")

      # Entity should not have attribute-level tail remarks
      entity_remarks = entity.untagged_remarks || []
      entity_remark_texts = entity_remarks.map do |r|
        r.is_a?(Expressir::Model::RemarkInfo) ? r.text : r
      end
      expect(entity_remark_texts).not_to include("Name in Japanese: 名前")
    end

    it "caches line number calculations" do
      attacher = described_class.new(
        File.read(exp_file),
        Set.new,
        ->(ctx) { [0, 10] }
      )

      # First call calculates
      line1 = attacher.get_line_number(50)
      # Second call uses cache
      line2 = attacher.get_line_number(50)

      expect(line1).to eq(line2)
      expect(attacher.instance_variable_get(:@line_cache)[50]).to eq(line1)
    end

    it "handles line number edge cases" do
      attacher = described_class.new(
        "test",
        Set.new,
        ->(ctx) { [0, 10] }
      )

      expect(attacher.get_line_number(nil)).to eq(1)
      expect(attacher.get_line_number(0)).to eq(1)
    end
  end
end