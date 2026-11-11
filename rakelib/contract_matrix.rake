# frozen_string_literal: true

# The contract matrix (issue #624): the canonical lane seals one
# artifact per wire shape; every lane re-derives the shape from the
# same source and must be byte-identical. Drift here is a release
# blocker — canonicalization changes are invisible to parse-level
# differentials (the parsanol rs#397 lesson).
namespace :contract_matrix do
  require "json"
  require "digest"
  require "tmpdir"

  MATRIX = "spec/fixtures/contract-matrix"
  SOURCE = File.join(MATRIX, "source.exp")

  def seal(shape, text)
    path = File.join(MATRIX, shape)
    File.write(path, text)
    Digest::SHA256.hexdigest(text)
  end

  desc "Seal the contract-matrix artifacts from the canonical lane"
  task :seal do
    require "expressir"
    Dir.mktmpdir do |dir|
      file = File.join(dir, "source.exp")
      FileUtils.cp(SOURCE, file)

      source = File.read(file)
      wire = Expressir::Express::Core.parse_to_model_hash(source, "source.exp")
      attached_model = Expressir::Express::Core.parse_to_model_attached_with_wire(
        source, "source.exp"
      )
      attached = JSON.parse(attached_model.core_wire)
      formatted = Expressir::Express::Core.format_model_hash(attached)
      stripped = Expressir::Express::Core.format_model_hash(attached, no_remarks: true)

      checksums = {
        "model-hash wire" => seal("wire.json", JSON.pretty_generate(wire) + "\n"),
        "attached wire" => seal("attached.json", JSON.pretty_generate(attached) + "\n"),
        "formatted text" => seal("formatted.exp", formatted),
        "stripped text" => seal("stripped.exp", stripped),
      }

      manifest = {
        "contract" => "what the canonical lane seals, every lane re-derives byte-identically",
        "source" => "source.exp",
        "canonical_lane" => "Expressir::Express::Core (the native extension)",
        "artifacts" => checksums.transform_values { |digest| "sha256:#{digest}" },
        "shapes" => %w[
          model-hash wire attached wire formatted text stripped text
        ],
      }
      File.write(File.join(MATRIX, "manifest.yml"), YAML.dump(manifest))
      puts "sealed #{checksums.size} artifacts + manifest.yml"
    end
  end
end
