# frozen_string_literal: true

require "spec_helper"
require "fileutils"
require "tmpdir"

# Schema resolution for the parity CLI commands: the ELF schema manifest is
# the primary mode; the STEPmod directory convention is an explicit fallback
# (#398, and the manifest-first directive).
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

  ARM = "SCHEMA Ap_tool_arm;\n" \
        "USE FROM support_resource_schema (label);\n" \
        "ENTITY base;\n  x : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n".freeze
  MIM = "SCHEMA Ap_tool_mim;\nUSE FROM Ap_tool_arm (base);\n" \
        "ENTITY part;\n  y : base;\nEND_ENTITY;\nEND_SCHEMA;\n".freeze
  SUPPORT = "SCHEMA support_resource_schema;\n" \
            "TYPE label = STRING; END_TYPE;\nEND_SCHEMA;\n".freeze

  describe "ELF schema manifest mode (--manifest)" do
    it "resolves the closure through the manifest, whatever the layout" do
      arm = write("anywhere/ap_tool_arm.exp", ARM)
      mim = write("deeper/nested/mim.exp", MIM)
      support = write("resources/support.exp", SUPPORT)
      manifest = write("manifest.yaml", <<~YAML)
        schemas:
          Ap_tool_arm:
            path: #{arm}
          Ap_tool_mim:
            path: #{mim}
          support_resource_schema:
            path: #{support}
      YAML

      paths = described_class.closure_paths(mim, manifest: manifest)
      aggregate_failures do
        expect(paths).to include(mim, arm, support)
      end
    end

    it "warns about schemas missing from the manifest" do
      mim = write("deeper/nested/mim.exp", MIM)
      manifest = write("manifest.yaml", <<~YAML)
        schemas:
          Ap_tool_mim:
            path: #{mim}
      YAML

      expect do
        paths = described_class.closure_paths(mim, manifest: manifest)
        expect(paths).to include(mim)
      end.to output(/not found: ap_tool_arm.*schema manifest/).to_stderr
    end
  end

  describe "STEPmod directory mode (--stepmod)" do
    it "indexes by declared schema name across the checkout" do
      write("schemas/modules/ap_tool/arm.exp", ARM)
      mim = write("schemas/modules/ap_tool/mim.exp", MIM)
      write("schemas/resources/support_resource_schema/support_resource_schema.exp",
            SUPPORT)

      paths = described_class.closure_paths(
        mim, stepmod: @dir,
      )
      aggregate_failures do
        expect(paths).to include(mim)
        expect(paths).to include(
          File.join(@dir, "schemas/modules/ap_tool/arm.exp"),
        )
        expect(paths).to include(
          File.join(@dir, "schemas/resources/support_resource_schema/" +
                          "support_resource_schema.exp"),
        )
      end
    end
  end

  describe "no explicit resolver" do
    it "warns and points at --manifest / --stepmod when a lookup fails" do
      mim = write("own/mim.exp", MIM)

      expect do
        paths = described_class.closure_paths(mim)
        expect(paths).to include(mim)
      end.to output(/provide --manifest PATH/).to_stderr
    end
  end
  describe "mutual USE FROM in the closure" do
    it "terminates and keeps both schemas (#397 family, closure side)" do
      write("own/mutual_a.exp",
            "SCHEMA mutual_a;\nUSE FROM mutual_b (y);\n" \
            "ENTITY x;\n  n : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n")
      write("own/mutual_b.exp",
            "SCHEMA mutual_b;\nUSE FROM mutual_a (x);\n" \
            "ENTITY y;\n  m : STRING;\nEND_ENTITY;\nEND_SCHEMA;\n")
      root = File.join(@dir, "own/mutual_a.exp")

      paths = described_class.closure_paths(root)
      expect(paths).to contain_exactly(root,
                                       File.join(@dir, "own/mutual_b.exp"))
    end
  end
end

