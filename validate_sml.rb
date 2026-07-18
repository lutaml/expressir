#!/usr/bin/env ruby
STDOUT.sync = true
require "expressir"
require "yaml"
require "timeout"
require "benchmark"

base_dir = "/Users/mulgogi/src/mn/iso-10303"

sml = YAML.load_file("#{base_dir}/schemas-sml-full.yml")
schemas = sml["schemas"].map { |name, info| ["SML/#{name}", "#{base_dir}/#{info['path']}"] }

total = schemas.size
pass = 0
failures = []

puts "Validating #{total} SML schemas (Ruby parser, 45s timeout)..."
puts "=" * 60

schemas.each_with_index do |(name, path), idx|
  unless File.exist?(path)
    failures << [name, "FILE NOT FOUND"]
    next
  end

  begin
    Timeout.timeout(45) do
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

  Expressir::Express::Grammar::Parser.clear_parser_cache rescue nil

  if (idx + 1) % 200 == 0
    puts "  [#{idx+1}/#{total}] pass=#{pass} fail=#{failures.size}"
  end
end

puts "=" * 60
puts "SML RESULTS: #{pass}/#{total} pass (#{(pass.to_f/total*100).round(1)}%), #{failures.size} failures"

# Categorize failures
parse_errors = failures.reject { |_, err| err == "TIMEOUT" || err == "FILE NOT FOUND" }
timeouts = failures.select { |_, err| err == "TIMEOUT" }
missing = failures.select { |_, err| err == "FILE NOT FOUND" }

puts "  Parse errors: #{parse_errors.size}"
puts "  Timeouts: #{timeouts.size}"
puts "  Missing: #{missing.size}"

puts "\nPARSE ERRORS:" if parse_errors.any?
parse_errors.first(30).each { |name, err| puts "  #{name}: #{err}" }

puts "\nTIMEOUTS (#{timeouts.size}):" if timeouts.any?
timeouts.first(10).each { |name, _| puts "  #{name}" }
