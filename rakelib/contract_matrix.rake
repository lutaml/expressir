# frozen_string_literal: true

# The contract matrix (issue #624): the canonical lane seals one
# artifact per wire shape; every lane re-derives the shape from the
# same source and must be byte-identical. Drift here is a release
# blocker — canonicalization changes are invisible to parse-level
# differentials (the parsanol rs#397 lesson).
#
# No file-level constants (rake double-loads rakelib); helpers stay
# inside the task body.
namespace :contract_matrix do
  require "json"
  require "digest"
  require "tmpdir"

  desc "Seal the contract-matrix artifacts from the canonical lane"
  task :seal do
    require "expressir"
    matrix = "spec/fixtures/contract-matrix"
    source_path = File.join(matrix, "source.exp")

    seal = lambda do |shape, text|
      File.write(File.join(matrix, shape), text)
      Digest::SHA256.hexdigest(text)
    end

    Dir.mktmpdir do |dir|
      file = File.join(dir, "source.exp")
      FileUtils.cp(source_path, file)

      source = File.read(file)
      wire = Expressir::Express::Core.parse_to_model_hash(source, "source.exp")
      attached_model = Expressir::Express::Core.parse_to_model_attached_with_wire(
        source, "source.exp"
      )
      attached = JSON.parse(attached_model.core_wire)
      formatted = Expressir::Express::Core.format_model_hash(attached)
      stripped = Expressir::Express::Core.format_model_hash(attached, no_remarks: true)

      checksums = {
        "model-hash wire" => seal.call("wire.json", "#{JSON.pretty_generate(wire)}\n"),
        "attached wire" => seal.call("attached.json", "#{JSON.pretty_generate(attached)}\n"),
        "formatted text" => seal.call("formatted.exp", formatted),
        "stripped text" => seal.call("stripped.exp", stripped),
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
      File.write(File.join(matrix, "manifest.yml"), YAML.dump(manifest))
      puts "sealed #{checksums.size} artifacts + manifest.yml"
    end
  end
end
