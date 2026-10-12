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
  # calibration: the exts load and parse in a bare child
  "load" => [60, <<~'R'],
    require "expressir"
    spec = Gem.loaded_specs["parsanol"]
    puts "parsanol=#{spec.full_name} platform=#{spec.platform}"
    puts "parsanol_native=#{Parsanol::Native.available?}"
    puts "core_native=#{Expressir::Express::Core::NATIVE_AVAILABLE}"
  R
  # the CLI require chain alone — no dispatch, no rspec
  "cli_require_only" => [120, <<~'R'],
    t = Time.now
    require "expressir"
    require "expressir/cli"
    puts "cli_require_only=true seconds=#{(Time.now - t).round(1)}"
  R
  # exactly what the suite hangs in: in-process Cli.start with a
  # captured $stdout, in a bare child (no rspec)
  "cli_version" => [180, <<~'R'],
    require "expressir"
    require "expressir/cli"
    sio = StringIO.new
    orig = $stdout
    $stdout = sio
    Expressir::Cli.start(["version"])
    $stdout = orig
    puts "cli_version_output=#{sio.string.strip.inspect}"
  R
  # rspec itself on a trivial spec — boots the harness, no expressir
  "rspec_boot" => [180, <<~'R'],
    require "tmpdir"
    dir = File.join(Dir.tmpdir, "ladder_spec")
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.write(File.join(dir, "boot_spec.rb"), <<~SPEC)
      require "rspec"
      RSpec.describe "boot" do
        it "passes" do
          expect(1).to eq(1)
        end
      end
    SPEC
    ok = system("bundle", "exec", "rspec", File.join(dir, "boot_spec.rb"),
                "--format", "progress", "--no-color")
    puts "rspec_boot_exit=#{ok}"
  R
  # the exact spec file the suite dies in
  "rspec_version_spec" => [600, <<~'R'],
    ok = system("bundle", "exec", "rspec", "spec/acceptance/version_spec.rb",
                "--format", "progress", "--no-color")
    puts "rspec_version_spec_exit=#{ok}"
  R
  # the other in-process-Cli.start spec family
  "rspec_cli_parity" => [600, <<~'R'],
    ok = system("bundle", "exec", "rspec", "spec/expressir/cli_parity_spec.rb",
                "--format", "progress", "--no-color")
    puts "rspec_cli_parity_exit=#{ok}"
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
  out.empty? ? nil : out.lines.first.strip
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
