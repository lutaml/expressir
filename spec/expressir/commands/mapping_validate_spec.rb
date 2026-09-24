# frozen_string_literal: true

require "spec_helper"
require "tempfile"
require "thor"

RSpec.describe Expressir::Commands::MappingValidate do
  def write_module(dir, mapping_body)
    File.write(File.join(dir, "arm.exp"),
               "SCHEMA m_arm;\nENTITY thing; a : STRING; END_ENTITY;\nEND_SCHEMA;\n")
    File.write(File.join(dir, "mim.exp"),
               "SCHEMA m_mim;\nUSE FROM m_arm (thing);\nENTITY thing; a : STRING; END_ENTITY;\nEND_SCHEMA;\n")
    File.write(File.join(dir, "mapping.yaml"), mapping_body)
  end

  it "passes for a mapping whose links all resolve" do
    Dir.mktmpdir("mapping-cli") do |dir|
      write_module(dir, <<~YAML)
        ---
        ae:
        - entity: <<express:m_arm.thing,thing>>
          aimelt: <<express:m_mim.thing,thing>>
        sc: []
      YAML
      expect do
        described_class.new({}).run(File.join(dir, "mapping.yaml"))
      end.not_to raise_error
    end
  end

  it "raises on unknown links" do
    Dir.mktmpdir("mapping-cli") do |dir|
      write_module(dir, <<~YAML)
        ---
        ae:
        - entity: <<express:m_arm.thing,thing>>
          aimelt: <<express:ghost_schema.thing,thing>>
        sc: []
      YAML
      expect do
        described_class.new({}).run(File.join(dir, "mapping.yaml"))
      end.to raise_error(Thor::Error, /1 unknown link/)
    end
  end

  it "passes when reference paths resolve against the schemas" do
    Dir.mktmpdir("mapping-cli") do |dir|
      write_module(dir, <<~YAML)
        ---
        ae:
        - entity: <<express:m_arm.thing,thing>>
          aimelt: <<express:m_mim.thing,thing>>
          refpath:
            content: |-
              thing
              thing.a -> thing
        sc: []
      YAML
      expect do
        described_class.new({}).run(File.join(dir, "mapping.yaml"))
      end.not_to raise_error
    end
  end

  it "raises on a reference path naming an unknown type (#88)" do
    Dir.mktmpdir("mapping-cli") do |dir|
      write_module(dir, <<~YAML)
        ---
        ae:
        - entity: <<express:m_arm.thing,thing>>
          aimelt: <<express:m_mim.thing,thing>>
          refpath:
            content: |-
              ghost_type <= thing
        sc: []
      YAML
      expect do
        described_class.new({}).run(File.join(dir, "mapping.yaml"))
      end.to raise_error(Thor::Error, /1 refpath issue/)
    end
  end

  it "raises when no arm/mim sits next to the mapping" do
    Dir.mktmpdir("mapping-cli") do |dir|
      File.write(File.join(dir, "mapping.yaml"), "---\nae: []\nsc: []\n")
      expect do
        described_class.new({}).run(File.join(dir, "mapping.yaml"))
      end.to raise_error(Thor::Error, /no arm.exp\/mim.exp/)
    end
  end
end
