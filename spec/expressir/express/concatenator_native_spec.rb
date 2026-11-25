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

    expect(native.map(&:id).downcase.sort).to eq(ruby.map(&:id).downcase.sort)
    # The artifact bodies agree past the banner (both embed verbatim).
    expect(File.read(native_out)).to include(File.read(ruby_out).split("--\n").last.strip)
  end
end
