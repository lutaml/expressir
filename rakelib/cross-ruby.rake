require "rbconfig"
require "shellwords"

WINDOWS_PLATFORM_REGEX = /mingw|mswin/.freeze
LINUX_PLATFORM_REGEX = /linux/.freeze
DARWIN_PLATFORM_REGEX = /darwin/.freeze

CrossRuby = Struct.new(:version, :host) do
  def windows?
    !!(platform =~ WINDOWS_PLATFORM_REGEX)
  end

  def linux?
    !!(platform =~ LINUX_PLATFORM_REGEX)
  end

  def darwin?
    !!(platform =~ DARWIN_PLATFORM_REGEX)
  end

  def ver
    @ver ||= version[/\A[^-]+/]
  end

  def minor_ver
    @minor_ver ||= ver[/\A\d\.\d(?=\.)/]
  end

  def api_ver_suffix
    case minor_ver
    when nil
      raise "CrossRuby.api_ver_suffix: unsupported version: #{ver}"
    else
      minor_ver.delete(".") << "0"
    end
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  def platform
    @platform ||=
      case host
      when /\Ax86_64.*mingw32/
        "x64-mingw32"
      when /\Ax86_64.*linux/
        "x86_64-linux"
      when /\A(arm64|aarch64).*linux/
        "aarch64-linux"
      when /\Ai[3-6]86.*linux/
        "x86-linux"
      when /\Ax86_64-darwin/
        "x86_64-darwin"
      when /\Aarm64-darwin/
        "arm64-darwin"
      else
        raise "CrossRuby.platform: unsupported host: #{host}"
      end
  end

  def tool(name)
    (@binutils_prefix ||=
       case platform
       when "x64-mingw32"
         "x86_64-w64-mingw32-"
       when "x86_64-linux"
         "x86_64-redhat-linux-"
       when "aarch64-linux"
         "aarch64-redhat-linux-"
       when /x86_64.*darwin/
         "x86_64-apple-darwin-"
       when /a.*64.*darwin/
         "aarch64-apple-darwin-"
       else
         raise "CrossRuby.tool: unmatched platform: #{platform}"
       end) + name
  end

  def target_file_format
    case platform
    when "x64-mingw32"
      "pei-x86-64"
    when "x86_64-linux"
      "elf64-x86-64"
    when "aarch64-linux"
      "elf64-arm64"
    when "x86_64-darwin"
      "Mach-O 64-bit x86-64" # hmm
    when "arm64-darwin"
      "Mach-O arm64"
    else
      raise "CrossRuby.target_file_format: unmatched platform: #{platform}"
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity

  def dll_ext
    darwin? ? "bundle" : "so"
  end

  def dll_staging_path
    "tmp/#{platform}/stage/lib/#{GEMSPEC.name}/#{minor_ver}/#{GEMSPEC.name}.#{dll_ext}"
#    "tmp/#{platform}/express_parser/#{RUBY_VERSION}/express_parser.#{dll_ext}"
  end

  def allowed_dlls_mingw
    [
      "kernel32.dll",
      "msvcrt.dll",
      "ws2_32.dll",
      "user32.dll",
      "advapi32.dll",
      "x64-msvcrt-ruby#{api_ver_suffix}.dll",
    ]
  end

  def allowed_dlls_linux
    [
      "libm.so.6",
      *(if ver < "2.6.0"
          "libpthread.so.0"
        end),
      "libc.so.6",
      "libdl.so.2", # on old dists only - now in libc
    ]
  end

  def allowed_dlls_darwin
    [
      "/usr/lib/libSystem.B.dylib",
      "/usr/lib/liblzma.5.dylib",
      "/usr/lib/libobjc.A.dylib",
    ]
  end

  def allowed_dlls
    case platform
    when WINDOWS_PLATFORM_REGEX
      allowed_dlls_mingw
    when LINUX_PLATFORM_REGEX
      allowed_dlls_linux
    when DARWIN_PLATFORM_REGEX
      allowed_dlls_darwin
    else
      raise "CrossRuby.allowed_dlls: unmatched platform: #{platform}"
    end
  end

  def actual_dlls_mingw(dump)
    dump.scan(/DLL Name: (.*)$/).map(&:first).map(&:downcase).uniq
  end

  def actual_dlls_linux(dump)
    dump.scan(/NEEDED\s+(.*)/).map(&:first).uniq
  end

  def actual_dlls_darwin(ldd)
    ldd.scan(/^\t([^ ]+) /).map(&:first).uniq
  end

  def dll_ref_versions
    case platform
    when LINUX_PLATFORM_REGEX
      { "GLIBC" => "2.17" }
    else
      raise "CrossRuby.dll_ref_versions: unmatched platform: #{platform}"
    end
  end
end

CROSS_RUBIES = File.read(".cross_rubies").split("\n").map do |line|
  case line
  when /\A([^#]+):([^#]+)/
    CrossRuby.new($1, $2)
  end
end.compact

ENV["RUBY_CC_VERSION"] = CROSS_RUBIES.map(&:ver).uniq.join(":")

require "rake_compiler_dock"

def actual_ref_versions(data)
  # Build a hash of library versions like {"LIBUDEV"=>"183", "GLIBC"=>"2.17"}
  data.each.with_object({}) do |(lib, ver), h|
    if !h[lib] || ver.split(".").map(&:to_i).pack("C*") > h[lib].split(".").map(&:to_i).pack("C*")
      h[lib] = ver
    end
  end
  h
end

def verify_ref_version(dump)
  ref_versions_data = dump.scan(/0x[\da-f]+ 0x[\da-f]+ \d+ (\w+)_([\d.]+)$/i)
  actual_ref_versions(ref_versions_data) == cross_ruby.dll_ref_versions
end

def process_dll_windows(dump)
  raise "export function Init_expressir not in dll #{dll}" unless /Table.*\sInit_expressir\s/mi === dump

  actual_dlls_mingw(dump)
end

def process_dll_linux(dump)
  nm = `#{["env", "LANG=C", cross_ruby.tool("nm"), "-D", dll].shelljoin}`
  raise "export function Init_expressir not in dll #{dll}" unless / T Init_expressir/.match?(nm)
  # Verify that the expected so version requirements match the actual dependencies.
  raise "unexpected so version requirements #{actual_ref_versions.inspect} in #{dll}" unless verify_ref_versions(dump)

  actual_dlls_linux(dump)
end

def process_dll_darwin
  nm = `#{["env", "LANG=C", cross_ruby.tool("nm"), "-g", dll].shelljoin}`
  raise "export function Init_expressir not in dll #{dll}" unless / T _?Init_expressir/.match?(nm)

  ldd = `#{["env", "LANG=C", cross_ruby.tool("otool"), "-L", dll].shelljoin}`
  actual_dlls_darwin(ldd)
end

def process_dll(dump)
  case platform
  when WINDOWS_PLATFORM_REGEX
    process_dll_windows(dump)
  when LINUX_PLATFORM_REGEX
    process_dll_linux(dump)
  when DARWIN_PLATFORM_REGEX
    process_dll_darwin
  else
    raise "CrossRuby.allowed_dlls: unmatched platform: #{platform}"
  end
end

def verify_dll(dll, cross_ruby)
  allowed_imports = cross_ruby.allowed_dlls
  dump = `#{["env", "LANG=C", cross_ruby.tool("objdump"), "-p", dll].shelljoin}`
  raise "unexpected file format for generated dll #{dll}" unless /file format #{Regexp.quote(cross_ruby.target_file_format)}\s/ === dump

  actual_imports = process_dll(dump)
  # Verify that the DLL dependencies are all allowed.
  raise "unallowed so imports #{actual_imports.inspect} in #{dll} (allowed #{allowed_imports.inspect})" unless (actual_imports - allowed_imports).empty?

  puts "verify_dll: #{dll}: passed shared library sanity checks"
end

 CROSS_RUBIES.each do |cross_ruby|
  task cross_ruby.dll_staging_path do |t|
    JJJJ
    verify_dll t.name, cross_ruby
  end
 end

def gem_builder(plat)
  # use Task#invoke because the pkg/*gem task is defined at runtime
  Rake::Task["native:#{plat}"].invoke
  Rake::Task["pkg/#{GEMSPEC.full_name}-#{Gem::Platform.new(plat)}.gem"].invoke
end

REDHAT_PREREQ = "sudo yum install -y git".freeze
UBUNTU_PREREQ = "sudo apt-get update -y && sudo apt-get install -y automake autoconf libtool build-essential".freeze

def pre_req(plat)
  case plat
  when /\linux/
    "if [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release) == '\"Ubuntu\"' ]]; then #{UBUNTU_PREREQ}; else #{REDHAT_PREREQ}; fi"
  else
    UBUNTU_PREREQ.to_s
  end
end

namespace "gem" do
  CROSS_RUBIES.find_all { |cr| cr.windows? || cr.linux? || cr.darwin? }.map(&:platform).uniq.each do |plat|
    desc "build native gem for #{plat} platform"
    task plat do
      RakeCompilerDock.sh <<~RCD, platform: plat
        #{pre_req(plat)} &&
        gem install bundler --no-document &&
        bundle &&
        bundle exec rake gem:#{plat}:builder MAKE='nice make -j`nproc`'
      RCD
    end

    namespace plat do
      desc "build native gem for #{plat} platform (guest container)"
      task "builder" do
        gem_builder(plat)
      end
    end
  end

  desc "build native gems for windows"
  multitask "windows" => CROSS_RUBIES.find_all(&:windows?).map(&:platform).uniq

  desc "build native gems for linux"
  multitask "linux" => CROSS_RUBIES.find_all(&:linux?).map(&:platform).uniq

  desc "build native gems for darwin"
  multitask "darwin" => CROSS_RUBIES.find_all(&:darwin?).map(&:platform).uniq
end

require "rake/extensiontask"

Rake::ExtensionTask.new("express_parser", GEMSPEC) do |ext|
  ext.ext_dir = "ext/express-parser"
  ext.lib_dir = File.join(*["lib", "expressir", "express", ENV.fetch("FAT_DIR", nil)].compact)
  ext.config_options << ENV.fetch("EXTOPTS", nil)
  ext.cross_compile  = true
  ext.cross_platform = CROSS_RUBIES.map(&:platform).uniq
  ext.cross_config_options << "--enable-cross-build"
  ext.cross_compiling do |spec|
    spec.files.reject! { |path| File.fnmatch?("ext/*", path) }
    spec.dependencies.reject! { |dep| dep.name == "rice" }
  end
end
