# frozen_string_literal: true

# expressir#659 acceptance: the cold per-schema parse parallelizes.
# Generates a 250-schema corpus, then compares wall time of:
#   1. the per-file loop (250 × from_file — the production shape),
#   2. sequential from_files (EXPRESSIR_BATCH=0),
#   3. the batch lane (default, all cores),
#   4. the batch lane capped at 4 workers.
# Verifies the batch lane's models are identical to sequential's.

require "expressir"
require "fileutils"
require "tmpdir"

DIR = File.join(Dir.tmpdir, "expressir-659-corpus")
FILE_COUNT = 250

def generate_corpus
  FileUtils.mkdir_p(DIR)
  FILE_COUNT.times do |i|
    name = format("bench_schema_%03d", i)
    entities = Array.new(20 + (i % 30)) do |j|
      attrs = Array.new(3 + (j % 7)) do |k|
        "  attr_#{j}_#{k} : OPTIONAL STRING;\n"
      end.join
      "ENTITY e_#{j};\n#{attrs}END_ENTITY;\n"
    end.join
    func = <<~FUNC
      FUNCTION f_1(x : INTEGER) : INTEGER;
        RETURN(x * 2);
      END_FUNCTION;
      RULE r_1 FOR (e_0);
        WHERE
          wr1 : SIZEOF(e_0.attr_0_0) > 0;
        END_WHERE;
      END_RULE;
    FUNC
    File.write(File.join(DIR, "#{name}.exp"),
               "SCHEMA #{name};\n#{entities}#{func}END_SCHEMA;\n")
  end
end

def wall(label)
  t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  yield
  dt = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
  puts format("%-42s %8.2f s", label, dt)
  dt
end

generate_corpus
files = Dir[File.join(DIR, "*.exp")]
puts "corpus: #{files.size} schemas, #{File.join(DIR)}"

loop_dt = wall("per-file loop (250 x from_file)") do
  files.each { |f| Expressir::Express::Parser.from_file(f, skip_references: true) }
end

ENV["EXPRESSIR_BATCH"] = "0"
seq = nil
seq_dt = wall("from_files sequential (EXPRESSIR_BATCH=0)") do
  seq = Expressir::Express::Parser.from_files(files, skip_references: true)
end
ENV.delete("EXPRESSIR_BATCH")

batch = nil
batch_dt = wall("from_files batch (all cores)") do
  batch = Expressir::Express::Parser.from_files(files, skip_references: true)
end

wall("from_files batch (4 workers)") do
  Expressir::Express::Parser.from_files(files, skip_references: true,
                                               max_processes: 4)
end

identical = batch.to_hash == seq.to_hash
puts "models identical: #{identical}"
puts "batch speedup vs per-file loop: #{(loop_dt / batch_dt).round(2)}x"
puts "batch speedup vs sequential:    #{(seq_dt / batch_dt).round(2)}x"
abort "MODEL MISMATCH" unless identical
