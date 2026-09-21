# frozen_string_literal: true

require "spec_helper"
require "fileutils"
require "tmpdir"

# Review finding #398: the STEPmod schema index must (1) find the ancestor
# directory named `schemas` from any depth below it, and (2) key entries on
# the declared schema name — wg12-step module files are arm.exp / mim.exp.
RSpec.describe Expressir::Commands::ParityInputs do
  around do |example|
    @dir = Dir.mktmpdir("stepmod-")
    example.run
  ensure
    FileUtils.remove_entry(@dir) if @dir
  end

  def write(rel_path, content)
    path = File.join(@dir, rel_path)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content)
    path
  end

  it "finds the schemas root from below modules/ and keys on schema names" do
    write("schemas/modules/ap_tool/arm.exp",
          "SCHEMA Ap_tool_arm;\nUSE FROM support_resource_schema (label);\n" \
          "ENTITY base;\n  x : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n")
    write("schemas/modules/ap_tool/mim.exp",
          "SCHEMA Ap_tool_mim;\nUSE FROM Ap_tool_arm (base);\n" \
          "ENTITY part;\n  y : base;\nEND_ENTITY;\nEND_SCHEMA;\n")
    write("schemas/resources/support_resource_schema/support_resource_schema.exp",
          "SCHEMA support_resource_schema;\nTYPE label = STRING; END_TYPE;\nEND_SCHEMA;\n")

    mim = File.join(@dir, "schemas/modules/ap_tool/mim.exp")
    paths = described_class.closure_paths(mim)

    aggregate_failures do
      expect(paths).to include(mim)
      expect(paths).to include(
        File.join(@dir, "schemas/modules/ap_tool/arm.exp"),
      )
      expect(paths).to include(
        File.join(@dir, "schemas/resources/support_resource_schema/" \
                         "support_resource_schema.exp"),
      )
    end
  end
end
