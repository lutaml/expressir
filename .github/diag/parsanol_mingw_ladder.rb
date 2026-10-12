# frozen_string_literal: true

# parsanol-ruby#205 mingw hang ladder. Each probe runs in a child
# process so a hang cannot take the parent down; the parent enforces a
# hard timeout, samples the child's CPU twice (a climbing delta means a
# busy loop, a flat delta a blocked wait), captures a minidump via
# procdump when available, then kills and records.
require "rbconfig"
require "fileutils"

RUBY = RbConfig.ruby
DUMPS = File.join(__dir__, "..", "..", "dumps").freeze
FileUtils.mkdir_p(DUMPS)

LARGE = Dir.glob(File.join(__dir__, "..", "..", "spec", "**", "*.exp"))
            .max_by { |f| File.size(f) }
SMALL = File.join(__dir__, "..", "..", "spec", "syntax", "derived_attribute.exp")

puts "small fixture: #{SMALL} (#{File.size(SMALL)} bytes)"
puts "large fixture: #{LARGE} (#{File.size(LARGE)} bytes)"

PROBES = {
  "load" => [60, <<~'R'],
    require "parsanol"
    spec = Gem.loaded_specs["parsanol"]
    puts "parsanol=#{spec.full_name} platform=#{spec.platform}"
    puts "native_available=#{Parsanol::Native.available?}"
  R
  "tiny_parse" => [90, <<~'R'],
    require "parsanol"
    k = Class.new(Parsanol::Parser) do
      rule(:digit) { match['0-9'] }
      rule(:number) { digit.repeat(1).as(:n) }
      rule(:expr) { number >> match[' '].repeat >> match['+'] >> match[' '].repeat >> number }
      root :expr
    end
    puts "tiny_parse=#{k.new.parse('1 + 2', mode: :native).inspect}"
  R
  "serialize_grammar" => [180, <<~'R'],
    require "expressir"
    require "parsanol"
    atom = Expressir::Express::Grammar::Parser.new.syntax
    json = Parsanol::Native.serialize_grammar(atom)
    puts "grammar_json_bytes=#{json.bytesize}"
  R
  "parse_small" => [180, <<~'R'],
    require "expressir"
    require "parsanol"
    atom = Expressir::Express::Grammar::Parser.new.syntax
    src = File.read(ENV["LADDER_SMALL"])
    puts "native_parse_small=#{!Parsanol::Native.parse(atom, src).nil?} src_bytes=#{src.bytesize}"
  R
  "parse_large" => [300, <<~'R'],
    require "expressir"
    require "parsanol"
    atom = Expressir::Express::Grammar::Parser.new.syntax
    src = File.read(ENV["LADDER_LARGE"])
    res = src.bytesize > 1024 * 1024 ? Parsanol::Native.parse_fresh(atom, src) : Parsanol::Native.parse(atom, src)
    puts "native_parse_large=#{!res.nil?} src_bytes=#{src.bytesize}"
  R
  # The real hang's shape is expressir >= 30d028a1: dozens of sequential
  # native parses (parity/STEPmod specs parse every fixture). One big
  # parse is green in parsanol's own smoke; a LOOP is the untested shape.
  "parse_many" => [600, <<~'R'],
    require "expressir"
    require "parsanol"
    atom = Expressir::Express::Grammar::Parser.new.syntax
    files = Dir.glob(File.join(ENV["LADDER_ROOT"], "spec", "**", "*.exp")).sort
    done = 0
    files.each do |f|
      $stdout.puts "  parse_many: #{done}/#{files.size} next=#{File.basename(f)}"
      $stdout.flush
      src = File.read(f)
      begin
        Parsanol::Native.parse(atom, src)
      rescue Parsanol::ParseFailed => e
        $stdout.puts "  parse_many: skip #{File.basename(f)} (#{e.class})"
      end
      done += 1
    end
    puts "parse_many_completed=#{done}/#{files.size}"
  R
  "ruby_parse_control" => [300, <<~'R'],
    require "expressir"
    t = Time.now
    repo = Expressir::Express::Parser.from_file(ENV["LADDER_LARGE"], use_native: false, use_core: false)
    puts "ruby_parse_control=#{!repo.nil?} seconds=#{(Time.now - t).round(1)}"
  R
  # Core-path rungs (expressir's OWN native, expressir_core.so — the
  # surface from_file uses by default and the one expressir CI hangs
  # in). use_core defaults on, so these go through the Rust core.
  "core_parse_small" => [180, <<~'R'],
    require "expressir"
    puts "core_native_available=#{Expressir::Express::Core::NATIVE_AVAILABLE}"
    t = Time.now
    repo = Expressir::Express::Parser.from_file(ENV["LADDER_SMALL"])
    puts "core_parse_small=#{!repo.nil?} seconds=#{(Time.now - t).round(1)}"
  R
  "core_parse_large" => [300, <<~'R'],
    require "expressir"
    t = Time.now
    repo = Expressir::Express::Parser.from_file(ENV["LADDER_LARGE"])
    puts "core_parse_large=#{!repo.nil?} seconds=#{(Time.now - t).round(1)}"
  R
  "core_parse_many" => [600, <<~'R'],
    require "expressir"
    files = Dir.glob(File.join(ENV["LADDER_ROOT"], "spec", "**", "*.exp")).sort
    done = 0
    files.each do |f|
      $stdout.puts "  core_parse_many: #{done}/#{files.size} next=#{File.basename(f)}"
      $stdout.flush
      begin
        Expressir::Express::Parser.from_file(f)
      rescue StandardError => e
        $stdout.puts "  core_parse_many: skip #{File.basename(f)} (#{e.class})"
      end
      done += 1
    end
    puts "core_parse_many_completed=#{done}/#{files.size}"
  R
  # The specs that flipped in the onset window (#449): if the core rungs
  # above stay green, the hang may need the rspec harness around them.
  "spec_parity" => [600, <<~'R'],
    files = %w[
      spec/expressir_spec.rb
      spec/expressir/cli_parity_spec.rb
      spec/expressir/commands/parity_inputs_spec.rb
    ].select { |f| File.exist?(f) }
    ok = system("bundle", "exec", "rspec", *files,
                "--format", "progress", "--no-color")
    puts "spec_parity_exit=#{ok}"
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
  env = { "LADDER_SMALL" => SMALL, "LADDER_LARGE" => LARGE,
          "LADDER_ROOT" => File.expand_path(File.join(__dir__, "..", "..")) }
  r, w = IO.pipe
  t0 = Time.now
  pid = Process.spawn(env, RUBY, "-e", code, out: w, err: w)
  w.close
  reader = Thread.new { r.read }
  if reader.join(timeout)
    _status = Process.waitpid2(pid)[1]
    puts reader.value
    puts "   done in #{(Time.now - t0).round(1)}s"
  else
    puts "   HUNG after #{timeout}s"
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
  end
end

puts ""
puts failed.empty? ? "ALL RUNGS COMPLETED" : "HUNG RUNGS: #{failed.join(', ')}"
exit(failed.empty? ? 0 : 1)
