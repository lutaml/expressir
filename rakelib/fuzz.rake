# frozen_string_literal: true

# The differential fuzz (issue #624, mirroring parsanol's fuzz.yml):
# date-seeded mutations over the corpus, each source parsed + attached
# + formatted on BOTH lanes — the native extension and the pure-Ruby
# fallback (use_core: false, use_native: false) — with byte-exact
# comparison. Fallback drift cannot land.
#
#   rake fuzz                            # today's seed, 40 cases
#   rake fuzz SEED=20261107 CASES=200
#
# No file-level constants (rake double-loads rakelib); helpers stay
# inside the task body.
namespace :fuzz do
  require "tmpdir"
  require "fileutils"

  desc "Date-seeded differential fuzz across the native and fallback lanes"
  task :run do
    require "expressir"

    mutators = %i[
      squeeze_whitespace reword_remark rename_identifier
      splice_comment duplicate_line
    ].freeze

    corpus_sources = lambda do
      glob = ENV.fetch("FUZZ_CORPUS", "spec/fixtures/contract-matrix/source.exp")
      files = Dir[glob]
      files.empty? ? ["spec/fixtures/contract-matrix/source.exp"] : files
    end

    mutate = lambda do |source, rng|
      lines = source.lines
      rng.rand(1..3).times do
        case mutators[rng.rand(mutators.size)]
        when :squeeze_whitespace then lines.each { |l| l.gsub!(/[ \t]+/, " ") }
        when :reword_remark
          lines.each_with_index do |l, i|
            lines[i] = l.sub(/\(\*"(.*?)"\s*(.*?)\s*\*\)/) do
              "(\"#{Regexp.last_match(1)}\" reworded fuzz note #{i} *)"
            end
          end
        when :rename_identifier
          lines.map! { |l| l.sub(/\b(part|compatible)\b/) { "#{Regexp.last_match(0)}_#{rng.rand(100)}" } }
        when :splice_comment then lines.insert(rng.rand(lines.size + 1), +"(* a spliced fuzz comment *)\n")
        when :duplicate_line then lines.insert(rng.rand(lines.size + 1), lines[rng.rand(lines.size)].to_s.dup)
        end
      end
      lines.join
    end

    lane_outputs = lambda do |source, lane_options|
      Dir.mktmpdir do |dir|
        file = File.join(dir, "fuzz.exp")
        File.write(file, source)
        model = Expressir::Express::Parser.from_file(file, **lane_options)
        {
          "format" => Expressir::Express::Formatter.new.format(model),
          "stripped" => Expressir::Express::Formatter.new(no_remarks: true).format(model),
        }
      end
    end

    seed = Integer(ENV.fetch("FUZZ_SEED", Time.now.strftime("%Y%m%d")))
    cases = Integer(ENV.fetch("FUZZ_CASES", 40))
    rng = Random.new(seed)
    sources = corpus_sources.call
    export = ENV.fetch("FUZZ_EXPORT_DIR", "tmp/fuzz")

    failures = 0
    compared = 0

    cases.times do |i|
      base = sources[rng.rand(sources.size)]
      mutated = mutate.call(File.read(base), rng)
      begin
        native_outputs = lane_outputs.call(mutated, {})
        fallback_outputs = lane_outputs.call(mutated, { use_core: false, use_native: false })
        compared += 1
        native_outputs.each do |key, native_text|
          next if native_text == fallback_outputs[key]

          failures += 1
          FileUtils.mkdir_p(export)
          File.write(File.join(export, "case-#{i}-native.#{key}"), native_text)
          File.write(File.join(export, "case-#{i}-fallback.#{key}"), fallback_outputs[key])
          puts "DIVERGENT case #{i} (#{File.basename(base)}, seed #{seed}): #{key} — artifacts in #{export}"
        end
      rescue Expressir::Express::Error::SchemaParseFailure, Parsanol::ParseFailed
        # A mutation neither lane accepts is fine; a lane DIVERGENCE
        # (one parses, the other refuses) is what this must catch.
      end
    end

    puts "fuzz stats: seed=#{seed} cases=#{cases} compared=#{compared} divergent=#{failures}"
    abort "differential fuzz found #{failures} divergences" if failures.positive?
  end
end
