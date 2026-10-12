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

LARGE = Dir.glob(File.join(__dir__, "..", "..", "spec", "**", "*.exp"))
            .max_by { |f| File.size(f) }
SMALL = File.join(__dir__, "..", "..", "spec", "syntax", "derived_attribute.exp")

PROBES = {
  # calibration
  "load" => [60, <<~'R'],
    require "expressir"
    puts "core_native=#{Expressir::Express::Core::NATIVE_AVAILABLE}"
    puts "parsanol_native=#{Parsanol::Native.available?}"
  R
  # documents that the core never loads on rake-style runs (gemspec
  # has no extensions entry) — v4/v5 "core" rungs were the parsanol
  # path all along
  "core_load_debug" => [120, <<~'R'],
    begin
      require "expressir/expressir_core"
      puts "core_require=OK"
    rescue LoadError, StandardError => e
      puts "core_require_failed=#{e.class}: #{e.message}"
    end
    gem_dir = Gem.loaded_specs["expressir"].gem_dir
    ext_dir = File.join(gem_dir, "ext", "expressir_core")
    puts "ext_built_artifacts=#{Dir.glob(File.join(ext_dir, '*.{so,dll,bundle}')).length}"
  R
  # parsanol-native parse under GC pressure: rspec grows the heap and
  # the native arena's xmallocs (rb-sys global-allocator) can trigger
  # GC mid-parse — the rspec-vs-bare discriminator
  "parse_large_gc_pressure" => [600, <<~'R'],
    $stdout.sync = true
    require "expressir"
    atom = Expressir::Express::Grammar::Parser.new.syntax
    src = File.read(ENV["LADDER_LARGE"])
    2.times do |i|
      junk = Array.new(50_000) { "x" * 2048 }
      GC.start
      t = Time.now
      Parsanol::Native.parse(atom, src)
      puts "gc_pressure_round=#{i} ok seconds=#{(Time.now - t).round(1)}"
      junk = nil
      GC.start
    end
    puts "parse_large_gc_pressure=done"
  R
  # the full fixture loop AFTER heap churn (mid-parse GC probability)
  "parse_many_churn" => [600, <<~'R'],
    $stdout.sync = true
    require "expressir"
    junk = Array.new(100_000) { "y" * 2048 }
    atom = Expressir::Express::Grammar::Parser.new.syntax
    files = Dir.glob(File.join(ENV["LADDER_ROOT"], "spec", "**", "*.exp")).sort
    done = 0
    files.each do |f|
      $stdout.puts "  parse_many_churn: #{done}/#{files.size} next=#{File.basename(f)}"
      $stdout.flush
      begin
        Parsanol::Native.parse(atom, File.read(f))
      rescue Parsanol::ParseFailed
        nil
      end
      done += 1
    end
    puts "parse_many_churn_completed=#{done}/#{files.size} junk=#{junk.length}"
  R
  # the same expand WITHOUT rspec: if this hangs, the trigger is the
  # Cli/expand/parse shape alone and rspec is irrelevant
  "cli_expand_bare" => [300, <<~'R'],
    $stdout.sync = true
    require "tmpdir"
    require "stringio"
    require "expressir"
    require "expressir/cli"
    work = Dir.mktmpdir
    File.write(File.join(work, "support.exp"),
               "SCHEMA support;\nTYPE label = STRING; END_TYPE;\nEND_SCHEMA;\n")
    root = File.join(work, "root.exp")
    File.write(root, "SCHEMA root;\nUSE FROM support (label);\nEND_SCHEMA;\n")
    sio = StringIO.new
    orig = $stdout
    $stdout = sio
    Expressir::Cli.start(["expand", root])
    $stdout = orig
    puts "cli_expand_bare_ok=#{sio.string.include?('root')}"
  R
  # the known-hang control, now unbuffered: in-process rspec driving
  # cli_parity's shape — the hang's exact example is visible live
  "rspec_cli_parity_sync" => [600, <<~'R'],
    $stdout.sync = true
    require "tmpdir"
    spec = <<~SPEC
      require "spec_helper"
      require "stringio"
      RSpec.describe "cli parity minimal" do
        it "expands a closure in-process" do
          work = Dir.mktmpdir
          File.write(File.join(work, "support.exp"),
                     "SCHEMA support;\nTYPE label = STRING; END_TYPE;\nEND_SCHEMA;\n")
          root = File.join(work, "root.exp")
          File.write(root, "SCHEMA root;\nUSE FROM support (label);\nEND_SCHEMA;\n")
          out, code = nil, nil
          orig = $stdout
          $stdout = StringIO.new
          begin
            Expressir::Cli.start(["expand", root])
            out = $stdout.string
            code = 0
          ensure
            $stdout = orig
          end
          expect(code).to eq(0)
          expect(out).to include("root")
        end
      end
    SPEC
    path = File.join(Dir.mktmpdir, "cli_parity_min_spec.rb")
    File.write(path, spec)
    ARGV.replace(["--format", "progress", "--no-color", path])
    require "rspec"
    RSpec::Core::Runner.invoke
    puts "rspec_cli_parity_sync_done=#{$?.success?}"
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
  env = {
    "LADDER_ROOT" => File.expand_path(File.join(__dir__, "..", "..")),
    "LADDER_SMALL" => SMALL, "LADDER_LARGE" => LARGE,
  }
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
    stacks = File.join(DUMPS, "#{name}_stacks.txt")
    cdb = "C:/Program Files (x86)/Windows Kits/10/Debuggers/x64/cdb.exe"
    if File.exist?(cdb)
      out = `"#{cdb}" -p #{pid} -c "~*kb 120; qd" -logo "#{stacks}" 2>&1`
      puts "   cdb: exited #{$?.exitstatus} (#{File.exist?(stacks) ? File.size(stacks) : 0} bytes logged)"
    else
      puts "   cdb not present; trying procdump"
      if (pd = find_procdump)
        puts "   procdump: #{`#{pd.inspect} -accepteula -mm #{pid} #{dump.inspect} 2>&1`}"
        puts "   dump: #{dump} (#{File.exist?(dump) ? File.size(dump) : 'missing'})"
      else
        puts "   procdump not found; no dump"
      end
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
