require "spec_helper"

RSpec.describe Expressir::Express::RemarkAttacher do
  describe "integration tests with real parsing" do
    let(:exp_file) do
      Expressir.root_path.join("spec", "fixtures", "validate_ascii",
                               "non_ascii_in_remarks_only.exp")
    end
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
      source_content = File.read(exp_file)
      attacher = described_class.new(source_content)

      # First call calculates
      line1 = attacher.send(:get_line_number, 50)
      # Second call uses cache
      line2 = attacher.send(:get_line_number, 50)

      expect(line1).to eq(line2)
      expect(attacher.instance_variable_get(:@line_cache)[50]).to eq(line1)
    end

    it "handles line number edge cases" do
      attacher = described_class.new("test")

      expect(attacher.send(:get_line_number, nil)).to eq(1)
      expect(attacher.send(:get_line_number, 0)).to eq(1)
    end
  end

  describe "extract_all_remarks" do
    it "extracts tail remarks from source" do
      source = <<~EXP
        SCHEMA test;
        -- This is a tail remark
        ENTITY foo;
        END_ENTITY;
        END_SCHEMA;
      EXP

      attacher = described_class.new(source)
      remarks = attacher.send(:extract_all_remarks)

      expect(remarks).not_to be_empty
      expect(remarks.any? do |r|
        r[:text].include?("This is a tail remark")
      end).to be true
    end

    it "extracts embedded remarks from source" do
      source = <<~EXP
        SCHEMA test;
        (* This is an embedded remark *)
        ENTITY foo;
        END_ENTITY;
        END_SCHEMA;
      EXP

      attacher = described_class.new(source)
      remarks = attacher.send(:extract_all_remarks)

      expect(remarks).not_to be_empty
      expect(remarks.any? do |r|
        r[:text].include?("This is an embedded remark")
      end).to be true
    end

    it "extracts tagged remarks" do
      source = <<~EXP
        SCHEMA test;
        --"tag1" This is a tagged remark
        ENTITY foo;
        END_ENTITY;
        END_SCHEMA;
      EXP

      attacher = described_class.new(source)
      remarks = attacher.send(:extract_all_remarks)

      tagged = remarks.select { |r| r[:tag] }
      expect(tagged).not_to be_empty
      expect(tagged.first[:tag]).to eq("tag1")
    end
  end

  describe "attach" do
    it "attaches remarks to model elements" do
      source = <<~EXP
        SCHEMA test_schema;
        -- Schema level remark
        ENTITY test_entity;
        END_ENTITY;
        END_SCHEMA;
      EXP

      repo = Expressir::Express::Parser.from_exp(source)
      schema = repo.schemas.first

      # Remarks should be attached
      expect(schema.untagged_remarks).not_to be_empty
    end
  end
end
