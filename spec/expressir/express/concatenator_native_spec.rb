# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

# The concatenated artifact (expressir#247, #636): the closure walk runs
# in the Rust core when the extension is available and in Ruby on the
# no-native lane — the schema set and the artifact body must agree.
RSpec.describe Expressir::Express::Concatenator do
  let(:dir) do
    Dir.mktmpdir("concat636").tap do |d|
      {
        "description_assignment_arm.exp" =>
          "SCHEMA Description_assignment_arm;\nENTITY act;\n  id : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n",
        "description_assignment_mim.exp" =>
          "SCHEMA Description_assignment_mim;\nUSE FROM Description_assignment_arm (act);\nENTITY it;\n  act_ref : act;\nEND_ENTITY;\nEND_SCHEMA;\n",
        "unrelated.exp" => "SCHEMA Unrelated;\nEND_SCHEMA;\n",
      }.each do |name, text|
        File.binwrite(File.join(d, name), text)
      end
      d
    end
  end

  let(:paths) do
    %w[description_assignment_arm.exp description_assignment_mim.exp unrelated.exp]
      .map { |name| File.join(dir, name) }
  end

  let(:repository) { Expressir::Express::Parser.from_files(paths) }

  it "the closure carries the root and its interface targets, sorted" do
    root = repository.schemas.find { |s| s.id.casecmp?("description_assignment_mim") }
    schemas = described_class.call(root, repository, File.join(dir, "concat.exp"))

    expect(schemas.map { |s| s.id.downcase }).to eq(
      %w[description_assignment_arm description_assignment_mim],
    )
  end

  it "the artifact embeds each section verbatim behind its separator" do
    root = repository.schemas.find { |s| s.id.casecmp?("description_assignment_mim") }
    out = File.join(dir, "concat.exp")

    described_class.call(root, repository, out)

    text = File.read(out)
    expect(text).to include("Schemata for Concatenated File")
    expect(text).to include("-- DESCRIPTION_ASSIGNMENT_ARM (")
    expect(text).to include("SCHEMA Description_assignment_arm;")
    expect(text).to include("SCHEMA Description_assignment_mim;")
    expect(text).not_to include("SCHEMA Unrelated;")
  end

  it "round-trips: the concatenated file parses" do
    root = repository.schemas.find { |s| s.id.casecmp?("description_assignment_mim") }
    out = File.join(dir, "concat.exp")

    described_class.call(root, repository, out)

    file = Expressir::Express::Parser.from_file(out)
    expect(file.schemas.map { |x| x.id.downcase }).to contain_exactly(
      "description_assignment_arm", "description_assignment_mim"
    )
  end

  it "the native and Ruby closures agree" do
    skip "native extension not available" unless Expressir::Express::Core::NATIVE_AVAILABLE &&
      Expressir::Core.respond_to?(:concat_schema)

    root = repository.schemas.find { |s| s.id.casecmp?("description_assignment_mim") }
    native_out = File.join(dir, "native.exp")
    ruby_out = File.join(dir, "ruby.exp")

    native = described_class.call(root, repository, native_out)
    ruby = described_class.ruby_call(root, repository, ruby_out)

    expect(native.map { |x| x.id.downcase }.sort).to eq(ruby.map { |x| x.id.downcase }.sort)
    # The artifact bodies agree past the banner (both embed verbatim).
    expect(File.read(native_out)).to include(File.read(ruby_out).split("--\n").last.strip)
  end

  describe Expressir::Express::Core do
    before do
      skip "native extension not available" unless Expressir::Express::Core::NATIVE_AVAILABLE &&
        Expressir::Core.respond_to?(:concat_schema) && Expressir::Core.respond_to?(:flatten_schema)
    end

    let(:dir) do
      Dir.mktmpdir("core636").tap do |d|
        File.binwrite(
          File.join(d, "root.exp"),
          "SCHEMA Root;\nENTITY thing;\n  id : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n",
        )
        d
      end
    end

    let(:repository) do
      Expressir::Express::Parser.from_files([File.join(dir, "root.exp")])
    end

    # The shtolo and CLI paths pass a bare schema-id string; the
    # wrappers take either a schema object or the string (round-1 CI).
    it "concat_schema takes a string root id" do
      ids, = described_class.concat_schema(repository, "Root")
      expect(ids.map(&:downcase)).to eq(["root"])
    end

    it "concat_schema takes a schema object" do
      root = repository.schemas.first
      ids, = described_class.concat_schema(repository, root)
      expect(ids.map(&:downcase)).to eq(["root"])
    end

    it "flatten_schema takes a string root id" do
      result = described_class.flatten_schema(repository, "Root", "longform")
      expect(result).to be_a(String)
      expect(result).to include("longform")
    end
  end
end
