require "rbconfig"
require "shellwords"

WINDOWS_PLATFORM_REGEX = /mingw|mswin/.freeze
LINUX_PLATFORM_REGEX = /linux/.freeze
DARWIN_PLATFORM_REGEX = /darwin/.freeze
GLIBC_MIN_VERSION = "2.17".freeze

CrossRuby = Struct.new(:version, :host) do
  def dll_staging_path
    "tmp/#{platform}/stage/lib/expressir/express/#{minor_ver}/express_parser.#{dll_ext}"
  end

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

  def minor_ver_digi
    @minor_ver_digi = minor_ver.delete(".").to_i
  end

  def ucrt?
    minor_ver_digi >= 31
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
        if ucrt?
          "x64-mingw-ucrt"
        else
          "x64-mingw32"
        end
      when /\Ax86_64.*linux/
        "x86_64-linux"
      when /\A(arm64|aarch64).*linux/
        "aarch64-linux"
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
       when /x64-mingw(32|-ucrt)/
         "x86_64-w64-mingw32-"
       when /(x86_64|aarch64)-linux/
         # We do believe that we are on Linux and can use native tools
         ""
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
    when /64-mingw(32|-ucrt)/
      "pei-x86-64"
    when "x86_64-linux"
      "elf64-x86-64"
    when "aarch64-linux"
      "elf64-little"
    when "x86_64-darwin"
      "Mach-O 64-bit x86-64"
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

  def verify_format(dump, dll)
    format_match = (/file format #{Regexp.quote(target_file_format)}\s/ === dump)
    format_error = "Unexpected file format for '#{dll}', '#{target_file_format}' required"
    raise format_error unless format_match
  end

  def verify_entry_windows(dump, dll)
    unless /Table.*\sInit_express_parser\s/mi === dump
      raise "Export function Init_express_parser not in dll #{dll}"
    end
  end

  def verify_entry_linux(dll)
    nm = `#{["env", "LANG=C", tool("nm"), "-D", dll].shelljoin}`
    unless nm.include?(" T Init_express_parser")
      raise "Export function Init_express_parser not in dll #{dll}"
    end
  end

  def verify_entry_darwin(dll)
    nm = `#{["env", "LANG=C", tool("nm"), "-g", dll].shelljoin}`
    unless / T _?Init_express_parser/.match?(nm)
      raise "Export function Init_express_parser not in dll #{dll}"
    end
  end

  def verify_entry(dump, dll)
    case platform
    when WINDOWS_PLATFORM_REGEX
      verify_entry_windows(dump, dll)
    when LINUX_PLATFORM_REGEX
      verify_entry_linux(dll)
    when DARWIN_PLATFORM_REGEX
      verify_entry_darwin(dll)
    else
      raise "CrossRuby.verify_entry: unmatched platform: #{platform}"
    end
  end

  # rubocop:disable Metrics/MethodLength
  def allowed_dlls_ucrt
    ["kernel32.dll",
     "api-ms-win-crt-convert-l1-1-0.dll",
     "api-ms-win-crt-environment-l1-1-0.dll",
     "api-ms-win-crt-heap-l1-1-0.dll",
     "api-ms-win-crt-locale-l1-1-0.dll",
     "api-ms-win-crt-private-l1-1-0.dll",
     "api-ms-win-crt-runtime-l1-1-0.dll",
     "api-ms-win-crt-stdio-l1-1-0.dll",
     "api-ms-win-crt-string-l1-1-0.dll",
     "api-ms-win-crt-time-l1-1-0.dll",
     "api-ms-win-crt-filesystem-l1-1-0.dll",
     "api-ms-win-crt-math-l1-1-0.dll",
     "libwinpthread-1.dll",
     "x64-ucrt-ruby#{api_ver_suffix}.dll"]
  end
  # rubocop:enable Metrics/MethodLength

  def allowed_dlls_mingw
    [
      "kernel32.dll",
      "msvcrt.dll",
      "libwinpthread-1.dll",
      "x64-msvcrt-ruby#{api_ver_suffix}.dll",
    ]
  end

  def allowed_dlls_windows
    if ucrt?
      allowed_dlls_ucrt
    else
      allowed_dlls_mingw
    end
  end

  def allowed_dlls_linux
    suffix = (platform == "x86_64-linux" ? "x86-64" : "aarch64")
    [
      "ld-linux-#{suffix}.so",
      "libc.so",
      "libm.so",
      "libstdc++.so",
      "libgcc_s.so",
      "libpthread.so",
    ]
  end

  def allowed_dlls_darwin
    [
      "/usr/lib/libSystem.B.dylib",
      "/usr/lib/libc++.1.dylib",
    ]
  end

  def allowed_dlls
    case platform
    when WINDOWS_PLATFORM_REGEX
      allowed_dlls_windows
    when LINUX_PLATFORM_REGEX
      allowed_dlls_linux
    when DARWIN_PLATFORM_REGEX
      allowed_dlls_darwin
    else
      raise "CrossRuby.allowed_dlls: unmatched platform: #{platform}"
    end
  end

  def actual_dlls_linux(dump)
    dump.scan(/NEEDED\s+(.*)/).map(&:first).uniq
  end

  def actual_dlls_windows(dump)
    dump.scan(/DLL Name: (.*)$/).map { |x| x.first.downcase }.uniq
  end

  def actual_dlls_darwin(dll)
    ldd = `#{[tool("otool"), "-L", dll].shelljoin}`
    ldd.scan(/^\t([^ ]+) /).map(&:first).uniq
  end

  def actual_dlls(dump, dll)
    case platform
    when DARWIN_PLATFORM_REGEX
      actual_dlls_darwin(dll)
    when LINUX_PLATFORM_REGEX
      actual_dlls_linux(dump)
    when WINDOWS_PLATFORM_REGEX
      actual_dlls_windows(dump)
    else
      raise "CrossRuby.actual_dlls: unmatched platform: #{platform}"
    end
  end

  def verify_imports(dump, dll)
    l = actual_dlls(dump, dll)
    libs = allowed_dlls
    l.delete_if { |ln| libs.any? { |lib| ln.include?(lib) } }
    unless l.empty?
      raise "Unexpected references in '#{dll}' : #{l}"
    end
  end

  def lib_ref_versions(data)
    # Build a hash of library versions like {"LIBUDEV"=>"183", "GLIBC"=>"2.17"}
    data.each.with_object({}) do |(lib, ver), h|
      if !h[lib] || ver.split(".").map(&:to_i).pack("C*") > h[lib].split(".").map(&:to_i).pack("C*")
        h[lib] = ver
      end
    end
  end

  def verify_glibc_version(dump, dll)
    ref_versions_data = dump.scan(/0x[\da-f]+ 0x[\da-f]+ \d+ (\w+)_([\d.]+)$/i)
    ref_ver = lib_ref_versions(ref_versions_data)

    unless ref_ver["GLIBC"].delete(".").to_i <= GLIBC_MIN_VERSION.delete(".").to_i
      raise "Unexpected GLIBC version #{ref_ver['GLIBC']} for #{dll},  #{GLIBC_MIN_VERSION} or lower is expected"
    end
  end
end

CROSS_RUBIES = File.read(".cross_rubies").split("\n").filter_map do |line|
  case line
  when /\A([^#]+):([^#]+)/
    CrossRuby.new($1, $2)
  end
end

ENV["RUBY_CC_VERSION"] = CROSS_RUBIES.map(&:ver).uniq.join(":")

require "rake_compiler_dock"

def verify_dll(dll, cross_ruby)
  dump = `#{["env", "LANG=C", cross_ruby.tool("objdump"), "-p", dll].shelljoin}`
  cross_ruby.verify_format(dump, dll)
  cross_ruby.verify_entry(dump, dll)
  cross_ruby.verify_imports(dump, dll)
  #  Not sure if it is required, probably not
  #  I am keeping related code as a reference for future advances
  #  cross_ruby.verify_glibc_version(dump, dll) if cross_ruby.linux?

  puts "#{dll}: passed shared library sanity checks"
end

CROSS_RUBIES.each do |cross_ruby|
  unless Rake::Task.task_defined?(cross_ruby.dll_staging_path)
    task cross_ruby.dll_staging_path do |t|
      verify_dll t.name, cross_ruby
    end
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
        bundle exec rake gem:#{plat}:builder MAKE="nice make -j`nproc`"
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
