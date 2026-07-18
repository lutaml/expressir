#!/usr/bin/env ruby
STDOUT.sync = true
require "expressir"
require "yaml"
require "timeout"
require "benchmark"

base_dir = "/Users/mulgogi/src/mn/iso-10303"

srl = YAML.load_file("#{base_dir}/schemas-srl.yml")
schemas = srl["schemas"].map { |name, info| ["SRL/#{name}", "#{base_dir}/#{info['path']}"] }

total = schemas.size
pass = 0
failures = []

puts "Validating #{total} SRL schemas (Ruby parser)..."
puts "=" * 60

schemas.each_with_index do |(name, path), idx|
  unless File.exist?(path)
    failures << [name, "FILE NOT FOUND"]
    next
  end

  time = Benchmark.realtime do
    begin
      Timeout.timeout(30) do
        source = File.read(path)
        exp_file = Expressir::Express::Parser.from_exp(source, skip_references: true, use_native: false)
        if exp_file.schemas&.any?
          pass += 1
        else
          failures << [name, "0 schemas parsed"]
        end
      end
    rescue Timeout::Error
      failures << [name, "TIMEOUT"]
    rescue => e
      failures << [name, "#{e.class}: #{e.message[0,120]}"]
    end
  end

  Expressir::Express::Grammar::Parser.clear_parser_cache rescue nil

  status = failures.any? { |n, _| n == name } ? "FAIL" : "OK"
  puts "  [#{idx+1}/#{total}] #{status} #{name} (#{time.round(2)}s)" if status == "FAIL" || time > 3
end

puts "=" * 60
puts "SRL RESULTS: #{pass}/#{total} pass (#{(pass.to_f/total*100).round(1)}%), #{failures.size} failures"
puts "\nFailures:" if failures.any?
failures.each { |name, err| puts "  #{name}: #{err}" }
