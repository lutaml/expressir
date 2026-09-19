# frozen_string_literal: true

# End-to-end performance demonstration for expressir-core.
#
# Compares the current Expressir pipeline (native parse -> Ruby AST
# hydration -> Ruby Builder) against the expressir-core Rust pipeline
# (parse -> parslet-normalize -> model extraction -> JSON) on the SMRL
# giant schemas.

repo_root = File.expand_path("../..", __dir__)
$LOAD_PATH.unshift File.join(repo_root, "lib")
require "expressir"
require "expressir/express/grammar/parser"
require "expressir/core"
require "json"

ROOT = ENV.fetch("EXPRESS_CORPUS_ROOT",
                   "/Users/mulgogi/src/mn/annotated-express-report/sources/" \
                   "report-pdf-latex-validation/SMRL_v7_EXPRESS_Source/data/resources")
FILES = [
  "aic_machining_feature/aic_machining_feature.exp",
  "mathematical_functions_schema/mathematical_functions_schema.exp",
].freeze

def bench(label, times: 3)
  results = []
  times.times do
    GC.start
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    yield
    results << Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
  end
  best = results.min
  puts format("  %-44s %7.2f s  (runs: %s)", label, best,
              results.map { |r| format("%.2f", r) }.join(", "))
  best
end

raise "expressir-core native not available" unless Expressir::Core::NATIVE_AVAILABLE

FILES.each do |rel|
  path = File.join(ROOT, rel)
  size = File.size(path) / 1024
  puts "== #{File.basename(path)} (#{size} KB)"

  repo = nil
  bench("from_file (current: parse + hydrate + Builder)") do
    repo = Expressir::Express::Parser.from_file(path)
  end

  bench("  stage: native parse only (parse_native)") do
    Expressir::Express::Grammar::Parser.parse_native(File.read(path))
  end

  json = nil
  bench("Expressir::Core.model_json (Rust: parse + extract + JSON)") do
    json = Expressir::Core.model_json(path)
  end
  puts format("     -> %d KB JSON, %d schemas, %d entities",
              json.bytesize / 1024,
              JSON.parse(json)["schemas"].size,
              JSON.parse(json)["schemas"].sum { |s| s["entities"].size })

  bench("  stage: Ruby JSON.parse of model_json") do
    JSON.parse(json)
  end

  # parity spot-check: schema and entity names must match the Builder
  rust = JSON.parse(json)["schemas"].map { |s| [s["name"], s["entities"].map { |e| e["name"] }] }
  ruby = repo.schemas.map { |s| [s.id, s.entities.map(&:id)] }
  puts ruby == rust ? "     parity: schema/entity names IDENTICAL" : "     parity: NAMES DIFFER"
  puts
end
