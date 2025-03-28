require "spec_helper"

RSpec.describe Expressir::Coverage do
  describe ".entity_documented?" do
    it "returns true for an entity with direct remarks" do
      # Create a test entity with remarks
      entity = Expressir::Model::Declarations::Entity.new(
        id: "test_entity",
        remarks: ["This is a test remark"],
      )

      expect(Expressir::Coverage.entity_documented?(entity)).to be true
    end

    it "returns false for an entity without remarks" do
      # Create a test entity without remarks
      entity = Expressir::Model::Declarations::Entity.new(
        id: "test_entity",
      )

      expect(Expressir::Coverage.entity_documented?(entity)).to be false
    end
  end

  describe "Report" do
    let(:sample_schema_path) { File.join("spec", "syntax", "remark.exp") }

    context "with a single file" do
      it "creates a report from a file" do
        report = Expressir::Coverage::Report.from_file(sample_schema_path)

        expect(report).to be_a(Expressir::Coverage::Report)
        expect(report.total_entities).not_to be_empty
        expect(report.file_reports).not_to be_empty
      end

      it "calculates coverage percentage" do
        report = Expressir::Coverage::Report.from_file(sample_schema_path)

        expect(report.coverage_percentage).to be_a(Float)
        expect(report.coverage_percentage).to be_between(0, 100)
      end
    end

    context "with a repository" do
      let(:repository) { Expressir::Express::Parser.from_file(sample_schema_path) }

      it "creates a report from a repository" do
        report = Expressir::Coverage::Report.from_repository(repository)

        expect(report).to be_a(Expressir::Coverage::Report)
        expect(report.repository).to eq(repository)
      end

      it "processes all schemas in the repository" do
        report = Expressir::Coverage::Report.from_repository(repository)

        expect(report.schema_reports.size).to eq(repository.schemas.size)
      end
    end
  end
end
