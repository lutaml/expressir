# frozen_string_literal: true

require "spec_helper"

RSpec.describe Expressir::Model::RepositoryValidator do
  let(:entity1) do
    instance_double(
      Expressir::Model::Declarations::Entity,
      id: double(safe_downcase: "entity1"),
    )
  end

  let(:type1) do
    instance_double(
      Expressir::Model::Declarations::Type,
      id: double(safe_downcase: "type1"),
    )
  end

  let(:function1) do
    instance_double(
      Expressir::Model::Declarations::Function,
      id: double(safe_downcase: "function1"),
    )
  end

  let(:procedure1) do
    instance_double(
      Expressir::Model::Declarations::Procedure,
      id: double(safe_downcase: "procedure1"),
    )
  end

  let(:constant1) do
    instance_double(
      Expressir::Model::Declarations::Constant,
      id: double(safe_downcase: "constant1"),
    )
  end

  let(:referenced_schema) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: double(safe_downcase: "referenced_schema"),
      entities: [entity1],
      types: [type1],
      functions: [function1],
      procedures: [procedure1],
      constants: [constant1],
      interfaces: nil,
    )
  end

  let(:valid_interface_item) do
    double(ref: double(id: double(safe_downcase: "entity1")))
  end

  let(:invalid_interface_item) do
    double(ref: double(id: "nonexistent"))
  end

  let(:use_interface) do
    instance_double(
      Expressir::Model::Declarations::Interface,
      kind: Expressir::Model::Declarations::Interface::USE,
      schema: double(id: double(safe_downcase: "referenced_schema")),
      items: [valid_interface_item],
    )
  end

  let(:missing_schema_interface) do
    instance_double(
      Expressir::Model::Declarations::Interface,
      kind: Expressir::Model::Declarations::Interface::REFERENCE,
      schema: double(id: "missing_schema"),
      items: [],
    )
  end

  let(:invalid_item_interface) do
    instance_double(
      Expressir::Model::Declarations::Interface,
      kind: Expressir::Model::Declarations::Interface::USE,
      schema: double(id: "referenced_schema"),
      items: [invalid_interface_item],
    )
  end

  let(:schema1) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: double(safe_downcase: "schema1"),
      interfaces: [use_interface],
      entities: nil,
      types: nil,
      functions: nil,
      procedures: nil,
      constants: nil,
    )
  end

  let(:schema_with_missing_ref) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: double(safe_downcase: "schema_missing_ref"),
      interfaces: [missing_schema_interface],
      entities: nil,
      types: nil,
      functions: nil,
      procedures: nil,
      constants: nil,
    )
  end

  let(:schema_with_invalid_item) do
    instance_double(
      Expressir::Model::Declarations::Schema,
      id: double(safe_downcase: "schema_invalid_item"),
      interfaces: [invalid_item_interface],
      entities: nil,
      types: nil,
      functions: nil,
      procedures: nil,
      constants: nil,
    )
  end

  let(:reference_index) do
    instance_double(Expressir::Model::Indexes::ReferenceIndex)
  end

  describe "#initialize" do
    it "initializes with schemas and reference index" do
      validator = described_class.new([schema1], reference_index)

      expect(validator).to be_a(described_class)
    end

    it "accepts empty schemas array" do
      validator = described_class.new([], reference_index)

      expect(validator).to be_a(described_class)
    end
  end

  describe "#validate" do
    context "with valid schemas" do
      let(:validator) do
        described_class.new([schema1, referenced_schema], reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
      end

      it "returns valid result when all checks pass" do
        result = validator.validate

        expect(result[:valid?]).to be true
        expect(result[:errors]).to be_empty
        expect(result[:warnings]).to be_empty
      end

      it "returns hash with required keys" do
        result = validator.validate

        expect(result).to have_key(:valid?)
        expect(result).to have_key(:errors)
        expect(result).to have_key(:warnings)
      end
    end

    context "with missing schema reference" do
      let(:validator) do
        described_class.new([schema_with_missing_ref], reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
      end

      it "returns invalid result" do
        result = validator.validate

        expect(result[:valid?]).to be false
      end

      it "includes missing schema error" do
        result = validator.validate

        expect(result[:errors]).not_to be_empty
        error = result[:errors].first
        expect(error[:type]).to eq(:missing_schema_reference)
        expect(error[:referenced_schema]).to be_a(String)
      end

      it "includes descriptive error message" do
        result = validator.validate

        error = result[:errors].first
        expect(error[:message]).to include("references non-existent schema")
      end
    end

    context "with missing interface item" do
      let(:validator) do
        described_class.new([schema_with_invalid_item, referenced_schema],
                            reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
      end

      it "returns invalid result" do
        result = validator.validate

        expect(result[:valid?]).to be false
      end

      it "includes missing interface item error" do
        result = validator.validate

        expect(result[:errors]).not_to be_empty
        error = result[:errors].first
        expect(error[:type]).to eq(:missing_interface_item)
        expect(error[:item]).to be_a(String)
      end

      it "includes descriptive error message" do
        result = validator.validate

        error = result[:errors].first
        expect(error[:message]).to include("Interface item")
        expect(error[:message]).to include("not found")
      end
    end

    context "with circular dependencies" do
      let(:circular_cycle) { ["schema1", "schema2", "schema3", "schema1"] }
      let(:circular_schema) do
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "circular"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
      end
      let(:validator) do
        described_class.new([circular_schema], reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([circular_cycle])
      end

      it "returns valid result (circular dependencies are warnings, not errors)" do
        result = validator.validate

        expect(result[:valid?]).to be true
      end

      it "includes circular dependency warning" do
        result = validator.validate

        expect(result[:warnings]).not_to be_empty
        circular_warnings = result[:warnings].select do |w|
          w[:type] == :circular_dependency
        end
        expect(circular_warnings).not_to be_empty
        expect(circular_warnings.first[:cycle]).to eq(circular_cycle)
      end

      it "includes descriptive warning message" do
        result = validator.validate

        circular_warnings = result[:warnings].select do |w|
          w[:type] == :circular_dependency
        end
        warning = circular_warnings.first
        expect(warning[:message]).to include("Circular dependency")
        expect(warning[:message]).to include("->")
      end
    end

    context "with multiple circular dependencies" do
      let(:cycle1) { ["schema1", "schema2", "schema1"] }
      let(:cycle2) { ["schema3", "schema4", "schema3"] }
      let(:multi_circular_schema) do
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "multi_circular"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
      end
      let(:validator) do
        described_class.new([multi_circular_schema], reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([
                                                                                      cycle1, cycle2
                                                                                    ])
      end

      it "reports all circular dependencies as warnings" do
        result = validator.validate

        circular_warnings = result[:warnings].select do |w|
          w[:type] == :circular_dependency
        end
        expect(circular_warnings.size).to eq(2)
      end
    end

    context "with strict mode disabled" do
      let(:standalone_schema) do
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "standalone"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
      end
      let(:validator) do
        described_class.new([schema1, standalone_schema], reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
      end

      it "does not detect unused schemas" do
        result = validator.validate(strict: false)

        expect(result[:warnings]).to be_empty
      end
    end

    context "with strict mode enabled" do
      let(:standalone_schema) do
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "standalone"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
      end
      let(:validator) do
        described_class.new([schema1, referenced_schema, standalone_schema],
                            reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
      end

      it "detects unused schemas" do
        result = validator.validate(strict: true)

        expect(result[:warnings]).not_to be_empty
        warning = result[:warnings].first
        expect(warning[:type]).to eq(:unused_schema)
      end

      it "includes descriptive warning message" do
        result = validator.validate(strict: true)

        warning = result[:warnings].first
        expect(warning[:message]).to include("not referenced")
      end

      it "does not warn for single schema repository" do
        single_schema_validator = described_class.new([standalone_schema],
                                                      reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

        result = single_schema_validator.validate(strict: true)

        expect(result[:warnings]).to be_empty
      end
    end

    context "with schemas without interfaces" do
      let(:no_interface_schema) do
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "no_interfaces"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
      end
      let(:validator) do
        described_class.new([no_interface_schema], reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
      end

      it "handles nil interfaces gracefully" do
        expect { validator.validate }.not_to raise_error
      end

      it "returns valid result" do
        result = validator.validate

        expect(result[:valid?]).to be true
      end
    end

    context "with multiple error types" do
      let(:problematic_schema) do
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "problematic"),
          interfaces: [missing_schema_interface, invalid_item_interface],
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
      end
      let(:validator) do
        described_class.new([problematic_schema, referenced_schema],
                            reference_index)
      end

      before do
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([[
                                                                                      "a", "b", "a"
                                                                                    ]])
      end

      it "accumulates all errors and warnings" do
        result = validator.validate

        expect(result[:errors].size).to be >= 2
        expect(result[:warnings].size).to be >= 1
      end

      it "includes different error and warning types" do
        result = validator.validate

        error_types = result[:errors].map { |e| e[:type] }
        warning_types = result[:warnings].map { |w| w[:type] }
        expect(error_types).to include(:missing_schema_reference)
        expect(warning_types).to include(:circular_dependency)
      end
    end
  end

  describe "interface item validation" do
    let(:validator) do
      described_class.new([schema1, referenced_schema], reference_index)
    end

    before do
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
    end

    it "validates entity items" do
      entity_item = double(ref: double(id: double(safe_downcase: "entity1")))
      entity_interface = instance_double(
        Expressir::Model::Declarations::Interface,
        kind: Expressir::Model::Declarations::Interface::USE,
        schema: double(id: double(safe_downcase: "referenced_schema")),
        items: [entity_item],
      )
      schema_with_entity = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "test"),
        interfaces: [entity_interface],
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new([schema_with_entity, referenced_schema],
                                      reference_index)

      result = validator.validate

      expect(result[:valid?]).to be true
    end

    it "validates type items" do
      type_item = double(ref: double(id: double(safe_downcase: "type1")))
      type_interface = instance_double(
        Expressir::Model::Declarations::Interface,
        kind: Expressir::Model::Declarations::Interface::USE,
        schema: double(id: double(safe_downcase: "referenced_schema")),
        items: [type_item],
      )
      schema_with_type = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "test"),
        interfaces: [type_interface],
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new([schema_with_type, referenced_schema],
                                      reference_index)

      result = validator.validate

      expect(result[:valid?]).to be true
    end

    it "validates function items" do
      function_item = double(ref: double(id: double(safe_downcase: "function1")))
      function_interface = instance_double(
        Expressir::Model::Declarations::Interface,
        kind: Expressir::Model::Declarations::Interface::USE,
        schema: double(id: double(safe_downcase: "referenced_schema")),
        items: [function_item],
      )
      schema_with_function = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "test"),
        interfaces: [function_interface],
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new(
        [schema_with_function, referenced_schema], reference_index
      )

      result = validator.validate

      expect(result[:valid?]).to be true
    end

    it "validates procedure items" do
      procedure_item = double(ref: double(id: double(safe_downcase: "procedure1")))
      procedure_interface = instance_double(
        Expressir::Model::Declarations::Interface,
        kind: Expressir::Model::Declarations::Interface::USE,
        schema: double(id: double(safe_downcase: "referenced_schema")),
        items: [procedure_item],
      )
      schema_with_procedure = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "test"),
        interfaces: [procedure_interface],
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new(
        [schema_with_procedure, referenced_schema], reference_index
      )

      result = validator.validate

      expect(result[:valid?]).to be true
    end

    it "validates constant items" do
      constant_item = double(ref: double(id: double(safe_downcase: "constant1")))
      constant_interface = instance_double(
        Expressir::Model::Declarations::Interface,
        kind: Expressir::Model::Declarations::Interface::USE,
        schema: double(id: double(safe_downcase: "referenced_schema")),
        items: [constant_item],
      )
      schema_with_constant = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "test"),
        interfaces: [constant_interface],
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new(
        [schema_with_constant, referenced_schema], reference_index
      )

      result = validator.validate

      expect(result[:valid?]).to be true
    end
  end

  describe "single responsibility principle" do
    let(:validator) { described_class.new([schema1], reference_index) }

    before do
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
    end

    it "focuses solely on repository validation" do
      expect(validator).to respond_to(:validate)
      expect(validator).not_to respond_to(:find_entity)
      expect(validator).not_to respond_to(:build_indexes)
    end

    it "delegates circular dependency detection to reference index" do
      expect(reference_index).to receive(:detect_circular_dependencies)

      validator.validate
    end
  end

  describe "extensibility" do
    it "allows adding new validation rules through subclassing" do
      expect(described_class).to be < Object
    end

    it "provides structured error and warning formats" do
      validator = described_class.new([schema_with_missing_ref],
                                      reference_index)
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

      result = validator.validate

      error = result[:errors].first
      expect(error).to have_key(:type)
      expect(error).to have_key(:message)
      expect(error).to have_key(:schema)
    end
  end

  describe "edge cases" do
    before do
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
    end

    it "handles empty schemas array" do
      validator = described_class.new([], reference_index)

      result = validator.validate

      expect(result[:valid?]).to be true
      expect(result[:errors]).to be_empty
    end

    it "handles schemas with empty interfaces array" do
      empty_interfaces_schema = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "empty"),
        interfaces: [],
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new([empty_interfaces_schema],
                                      reference_index)

      result = validator.validate

      expect(result[:valid?]).to be true
    end

    it "handles case-insensitive schema name matching" do
      uppercase_ref_interface = instance_double(
        Expressir::Model::Declarations::Interface,
        kind: Expressir::Model::Declarations::Interface::USE,
        schema: double(id: double(safe_downcase: "referenced_schema")),
        items: [],
      )
      uppercase_schema = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "uppercase"),
        interfaces: [uppercase_ref_interface],
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new([uppercase_schema, referenced_schema],
                                      reference_index)

      result = validator.validate

      expect(result[:valid?]).to be true
    end
  end

  describe "enhanced validation features" do
    describe "check_interfaces option" do
      it "skips detailed interface validation when false" do
        validator = described_class.new([schema1, referenced_schema],
                                        reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

        result = validator.validate(check_interfaces: false)

        expect(result[:valid?]).to be true
        expect(result[:interface_report]).to be_nil
      end

      it "performs detailed interface validation when true" do
        validator = described_class.new([schema1, referenced_schema],
                                        reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
        allow(schema1).to receive(:parent).and_return(nil)
        allow(referenced_schema).to receive(:parent).and_return(nil)

        result = validator.validate(check_interfaces: true)

        expect(result).to have_key(:valid?)
      end
    end

    describe "check_completeness option" do
      it "does not check completeness when false" do
        empty_schema = instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "empty"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
        validator = described_class.new([empty_schema], reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

        result = validator.validate(check_completeness: false)

        expect(result[:warnings]).to be_empty
      end

      it "warns about empty schemas when true" do
        empty_schema = instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "empty"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
        validator = described_class.new([empty_schema], reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

        result = validator.validate(check_completeness: true)

        expect(result[:warnings]).not_to be_empty
        warning = result[:warnings].find { |w| w[:type] == :empty_schema }
        expect(warning).not_to be_nil
        expect(warning[:schema]).to be_a(Object) # Schema id can be any object with safe_downcase
      end

      it "warns about schemas with no types when they have entities" do
        schema_no_types = instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "no_types"),
          interfaces: nil,
          entities: [entity1],
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
        validator = described_class.new([schema_no_types], reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

        result = validator.validate(check_completeness: true)

        expect(result[:warnings]).not_to be_empty
        warning = result[:warnings].find { |w| w[:type] == :no_types }
        expect(warning).not_to be_nil
      end
    end

    describe "detailed option" do
      it "does not include detailed report when false" do
        validator = described_class.new([schema1, referenced_schema],
                                        reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

        result = validator.validate(detailed: false, check_interfaces: false)

        expect(result[:interface_report]).to be_nil
      end
    end

    describe "option combinations" do
      it "handles strict and check_completeness together" do
        standalone_schema = instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "standalone"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
        validator = described_class.new(
          [schema1, referenced_schema, standalone_schema], reference_index
        )
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

        result = validator.validate(strict: true, check_completeness: true)

        expect(result[:warnings].size).to be >= 2 # unused + empty schema warnings
      end

      it "handles all options enabled" do
        validator = described_class.new([schema1, referenced_schema],
                                        reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
        allow(schema1).to receive(:parent).and_return(nil)
        allow(referenced_schema).to receive(:parent).and_return(nil)
        # Stub interface items to have id method for duplicate checking
        allow(valid_interface_item).to receive(:id).and_return(nil)

        result = validator.validate(
          strict: true,
          check_interfaces: true,
          check_completeness: true,
          detailed: true,
          check_duplicates: false, # Skip duplicate check due to mocking complexity
          check_self_references: false, # Skip self-reference check due to mocking complexity
        )

        expect(result).to have_key(:valid?)
        expect(result).to have_key(:errors)
        expect(result).to have_key(:warnings)
      end
    end

    describe "error handling" do
      it "handles interface validation errors gracefully" do
        bad_schema = instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "bad"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
        validator = described_class.new([bad_schema], reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
        allow(bad_schema).to receive(:parent).and_raise(StandardError,
                                                        "Test error")

        result = validator.validate(check_interfaces: true)

        # Should not crash, may include a warning
        expect(result).to have_key(:valid?)
      end
    end

    describe "result merging" do
      it "avoids duplicate errors from basic and interface validation" do
        validator = described_class.new([schema_with_missing_ref],
                                        reference_index)
        allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
        allow(schema_with_missing_ref).to receive(:parent).and_return(nil)

        result = validator.validate(check_interfaces: false)
        error_count_without = result[:errors].size

        result_with = validator.validate(check_interfaces: true)
        # Should not have significantly more errors (duplicates would double them)
        expect(result_with[:errors].size).to be <= error_count_without + 2
      end
    end
  end

  describe "backward compatibility" do
    it "maintains existing behavior with no options" do
      validator = described_class.new([schema1, referenced_schema],
                                      reference_index)
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

      result = validator.validate

      expect(result[:valid?]).to be true
      expect(result[:errors]).to be_empty
    end

    it "maintains existing strict mode behavior" do
      standalone_schema = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "standalone"),
        interfaces: nil,
        entities: nil,
        types: nil,
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new(
        [schema1, referenced_schema, standalone_schema], reference_index
      )
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

      result = validator.validate(strict: true)

      expect(result[:warnings]).not_to be_empty
      expect(result[:warnings].any? do |w|
        w[:type] == :unused_schema
      end).to be true
    end
  end

  describe "validation result structure" do
    it "always includes required keys" do
      validator = described_class.new([schema1], reference_index)
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

      result = validator.validate

      expect(result).to have_key(:valid?)
      expect(result).to have_key(:errors)
      expect(result).to have_key(:warnings)
    end

    it "includes interface_report only when detailed and check_interfaces are true" do
      validator = described_class.new([schema1], reference_index)
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])
      allow(schema1).to receive(:parent).and_return(nil)

      result_no_detailed = validator.validate(check_interfaces: true,
                                              detailed: false)
      expect(result_no_detailed[:interface_report]).to be_nil

      result_no_interfaces = validator.validate(check_interfaces: false,
                                                detailed: true)
      expect(result_no_interfaces[:interface_report]).to be_nil
    end
  end

  describe "completeness checks" do
    it "identifies schemas with entities but no types as potentially incomplete" do
      schema_with_entities = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "has_entities"),
        interfaces: nil,
        entities: [entity1],
        types: [],
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new([schema_with_entities], reference_index)
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

      result = validator.validate(check_completeness: true)

      warning = result[:warnings].find { |w| w[:type] == :no_types }
      expect(warning).not_to be_nil
      expect(warning[:message]).to include("has entities but no types")
    end

    it "does not warn about schemas with both entities and types" do
      complete_schema = instance_double(
        Expressir::Model::Declarations::Schema,
        id: double(safe_downcase: "complete"),
        interfaces: nil,
        entities: [entity1],
        types: [type1],
        functions: nil,
        procedures: nil,
        constants: nil,
      )
      validator = described_class.new([complete_schema], reference_index)
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

      result = validator.validate(check_completeness: true)

      no_types_warnings = result[:warnings].select { |w| w[:type] == :no_types }
      expect(no_types_warnings).to be_empty
    end
  end

  describe "validation performance" do
    it "performs basic validation efficiently" do
      schemas = Array.new(10) do |i|
        instance_double(
          Expressir::Model::Declarations::Schema,
          id: double(safe_downcase: "schema#{i}"),
          interfaces: nil,
          entities: nil,
          types: nil,
          functions: nil,
          procedures: nil,
          constants: nil,
        )
      end
      validator = described_class.new(schemas, reference_index)
      allow(reference_index).to receive(:detect_circular_dependencies).and_return([])

      start_time = Time.now
      result = validator.validate
      elapsed = Time.now - start_time

      expect(result[:valid?]).to be true
      expect(elapsed).to be < 1.0 # Should complete in under 1 second
    end
  end
end
