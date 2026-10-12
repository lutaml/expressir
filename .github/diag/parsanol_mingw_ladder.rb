# frozen_string_literal: true

# parsanol-ruby#205 mingw hang ladder, v4. v2 proved parsanol's own
# ext clean under load; v3 proved the expressir_core path clean under
# bare sequential parses (53/53) on BOTH expressir-rs pins, while the
# rspec harness hung (BLOCKED). The suite's hang decodes to
# spec/acceptance/version_spec.rb's "displays the current version" —
# an in-process Expressir::Cli.start under a captured $stdout. v4
# bisects that shape, streaming each child's output live so a hang
# shows exactly where it stopped.
require "rbconfig"
require "fileutils"
require "stringio"

RUBY = RbConfig.ruby
DUMPS = File.join(__dir__, "..", "..", "dumps").freeze
FileUtils.mkdir_p(DUMPS)

PROBES = {
  # calibration
  "load" => [60, <<~'R'],
    require "expressir"
    puts "core_native=#{Expressir::Express::Core::NATIVE_AVAILABLE}"
    puts "batch_available=#{Expressir::Express::Parser.batch_available? rescue 'n/a'}"
  R
  # THE repro candidate: from_files with >1 file routes to the native
  # batch workers (BatchStream -> std threads -> mpsc recv park).
  # Bare child, no rspec. Expect HANG on mingw if the batch park is
  # the defect.
  "batch_bare" => [300, <<~'R'],
    require "expressir"
    files = %w[spec/syntax/single.exp spec/syntax/derived_attribute.exp]
    t = Time.now
    repo = Expressir::Express::Parser.from_files(files, skip_references: true)
    puts "batch_bare_ok=#{!repo.nil?} schemas=#{repo.schemas.size} seconds=#{(Time.now - t).round(1)}"
  R
  # control: the documented escape hatch routes to sequential parsing
  "batch_escape" => [300, <<~'R'],
    ENV["EXPRESSIR_BATCH"] = "0"
    require "expressir"
    files = %w[spec/syntax/single.exp spec/syntax/derived_attribute.exp]
    t = Time.now
    repo = Expressir::Express::Parser.from_files(files, skip_references: true)
    puts "batch_escape_ok=#{!repo.nil?} schemas=#{repo.schemas.size} seconds=#{(Time.now - t).round(1)}"
  R
}.freeze

def powershell(cmd)
  `powershell.exe -NoProfile -Command #{cmd.inspect} 2>&1`.strip
end

def sample_cpu(pid)
  powershell("(Get-Process -Id #{pid}).CPU").to_f
end

def sample_threads(pid)
  powershell("(Get-Process -Id #{pid}).Threads | Group-Object ThreadState | " \
             "ForEach-Object { \"$($_.Count) x $($_.Name)\" }").lines.map(&:strip)
end

def find_procdump
  out = `where.exe procdump 2>NUL`.strip
  return out.lines.first.strip unless out.empty?

  candidates = Dir.glob([
    "C:/ProgramData/chocolatey/bin/procdump.exe",
    "C:/ProgramData/chocolatey/lib/sysinternals/tools/procdump.exe",
    "C:/Sysinternals/procdump.exe",
    "C:/Tools/Sysinternals/procdump.exe",
  ])
  candidates.find { |c| File.exist?(c) }
end

failed = []

PROBES.each do |name, (timeout, code)|
  puts ""
  puts "== #{name} (timeout #{timeout}s)"
  $stdout.flush
  env = { "LADDER_ROOT" => File.expand_path(File.join(__dir__, "..", "..")) }
  r, w = IO.pipe
  t0 = Time.now
  pid = Process.spawn(env, RUBY, "-e", code, out: w, err: w)
  w.close
  buffer = []
  reader = Thread.new do
    r.each_line do |line|
      buffer << line
      print "   | #{line}"
      $stdout.flush
    end
  rescue StandardError
    nil
  end
  deadline = t0 + timeout
  hung = false
  while reader.alive?
    if Time.now > deadline
      hung = true
      break
    end
    sleep 2
  end
  if hung
    puts "   HUNG after #{timeout}s (last output above)"
    cpu0 = sample_cpu(pid)
    sleep 5
    cpu1 = sample_cpu(pid)
    puts "   cpu: #{cpu0.round(2)} -> #{cpu1.round(2)} " \
         "(#{(cpu1 - cpu0).round(2)} delta: #{(cpu1 - cpu0) > 0.5 ? 'SPINNING' : 'BLOCKED'})"
    puts "   threads: #{sample_threads(pid).join(' | ')}"
    dump = File.join(DUMPS, "#{name}.dmp")
    if (pd = find_procdump)
      puts "   procdump: #{`#{pd.inspect} -accepteula -mm #{pid} #{dump.inspect} 2>&1`}"
      puts "   dump: #{dump} (#{File.exist?(dump) ? File.size(dump) : 'missing'})"
    else
      puts "   procdump not found; no dump"
    end
    Process.kill("KILL", pid)
    Process.waitpid(pid)
    reader.kill
    failed << name
  else
    Process.waitpid2(pid)
    puts "   done in #{(Time.now - t0).round(1)}s"
  end
end

puts ""
puts failed.empty? ? "ALL RUNGS COMPLETED" : "HUNG RUNGS: #{failed.join(', ')}"
exit(failed.empty? ? 0 : 1)
