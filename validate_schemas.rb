#!/usr/bin/env ruby
require "expressir"
require "yaml"
require "timeout"
require "benchmark"

base_dir = "/Users/mulgogi/src/mn/iso-10303"

# Load manifests
srl = YAML.load_file("#{base_dir}/schemas-srl.yml")
sml = YAML.load_file("#{base_dir}/schemas-sml-full.yml")

all_schemas = []
srl["schemas"].each { |name, info| all_schemas << ["SRL/#{name}", "#{base_dir}/#{info['path']}"] }
sml["schemas"].each { |name, info| all_schemas << ["SML/#{name}", "#{base_dir}/#{info['path']}"] }

total = all_schemas.size
results = { pass: 0, fail: 0, timeout: 0, missing: 0 }
failures = []
slow = []

puts "Validating #{total} schemas (Ruby parser, skip_references: true)..."
puts "=" * 70

all_schemas.each_with_index do |(name, path), idx|
  unless File.exist?(path)
    results[:missing] += 1
    failures << [name, path, "FILE NOT FOUND"]
    next
  end

  time = Benchmark.realtime do
    begin
      Timeout.timeout(60) do
        source = File.read(path)
        exp_file = Expressir::Express::Parser.from_exp(source, skip_references: true, use_native: false)
        schema_count = exp_file.schemas&.size || 0
        if schema_count == 0
          results[:fail] += 1
          failures << [name, path, "PARSED BUT 0 SCHEMAS"]
        else
          results[:pass] += 1
        end
      end
    rescue Timeout::Error
      results[:timeout] += 1
      failures << [name, path, "TIMEOUT (>60s)"]
    rescue => e
      results[:fail] += 1
      failures << [name, path, "#{e.class}: #{e.message[0,150]}"]
    end
  end

  slow << [name, time] if time > 5

  # Clear parser cache between schemas
  begin
    Expressir::Express::Grammar::Parser.clear_parser_cache
  rescue
    nil
  end

  # Progress every 100 schemas
  if (idx + 1) % 100 == 0
    puts "  [#{idx + 1}/#{total}] pass=#{results[:pass]} fail=#{results[:fail]} timeout=#{results[:timeout]} missing=#{results[:missing]}"
  end
end

puts "=" * 70
puts "RESULTS: #{results}"
puts "  Total: #{total}"
puts "  Pass:  #{results[:pass]} (#{(results[:pass].to_f / total * 100).round(1)}%)"
puts "  Fail:  #{results[:fail]}"
puts "  Timeout: #{results[:timeout]}"
puts "  Missing: #{results[:missing]}"

unless failures.empty?
  puts "\nFAILURES (#{failures.size}):"
  failures.each { |name, path, err| puts "  #{name}: #{err}" }
end

unless slow.empty?
  puts "\nSLOW SCHEMAS (>5s, #{slow.size}):"
  slow.sort_by { |_, t| -t }.first(20).each { |name, t| puts "  #{name}: #{t.round(2)}s" }
end
