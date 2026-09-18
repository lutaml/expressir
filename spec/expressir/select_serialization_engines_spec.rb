require "spec_helper"

RSpec.describe Expressir, ".select_serialization_engines" do
  def adapter_name(format)
    Lutaml::Model::Config.adapter_for(format).to_s
  end

  after do
    Lutaml::Model::Config.configure do |config|
      config.yaml_adapter_type = :standard
      config.json_adapter_type = :standard
    end
  end

  it "pins portable adapters on windows" do
    described_class.select_serialization_engines(windows: true)

    expect(adapter_name(:yaml)).to include("StandardAdapter")
    expect(adapter_name(:json)).to include("Standard")
    expect(adapter_name(:yaml)).not_to include("Yeptris")
  end

  it "leaves adapters untouched off windows" do
    described_class.select_serialization_engines(windows: false)

    expect(adapter_name(:yaml)).not_to include("Yeptris")
  end
end
