require "rbconfig"
require "shellwords"

CrossRuby = Struct.new(:version, :host) do
  WINDOWS_PLATFORM_REGEX = /mingw|mswin/
  MINGW32_PLATFORM_REGEX = /mingw32/
  LINUX_PLATFORM_REGEX = /linux/
  DARWIN_PLATFORM_REGEX = /darwin/

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

  def platform
    @platform ||= case host
      when /\Ax86_64.*mingw32/
        "x64-mingw32"
      when /\Ai[3-6]86.*mingw32/
        "x86-mingw32"
      when /\Ax86_64.*linux/
        "x86_64-linux"
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
    (@binutils_prefix ||= case platform
      when "x64-mingw32"
        "x86_64-w64-mingw32-"
      when "x86-mingw32"
        "i686-w64-mingw32-"
      when "x86_64-linux"
        "x86_64-redhat-linux-"
      when "x86-linux"
        "i686-redhat-linux-"
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
    when "x86-mingw32"
      "pei-i386"
    when "x86_64-linux"
      "elf64-x86-64"
    when "x86-linux"
      "elf32-i386"
    when "x86_64-darwin"
      "Mach-O 64-bit x86-64" # hmm
    when "arm64-darwin"
      "Mach-O arm64"
    else
      raise "CrossRuby.target_file_format: unmatched platform: #{platform}"
    end
  end

  def dll_ext
    darwin? ? "bundle" : "so"
  end

  def dll_staging_path
    "tmp/#{platform}/stage/lib/#{GEMSPEC.name}/#{minor_ver}/#{GEMSPEC.name}.#{dll_ext}"
  end

  def libruby_dll
    case platform
    when "x64-mingw32"
      "x64-msvcrt-ruby#{api_ver_suffix}.dll"
    when "x86-mingw32"
      "msvcrt-ruby#{api_ver_suffix}.dll"
    else
      raise "CrossRuby.libruby_dll: unmatched platform: #{platform}"
    end
  end

  def allowed_dlls
    case platform
    when MINGW32_PLATFORM_REGEX
      [
        "kernel32.dll",
        "msvcrt.dll",
        "ws2_32.dll",
        "user32.dll",
        "advapi32.dll",
        libruby_dll,
      ]
    when LINUX_PLATFORM_REGEX
      [
        "libm.so.6",
        *(case
        when ver < "2.6.0"
          "libpthread.so.0"
        end),
        "libc.so.6",
        "libdl.so.2", # on old dists only - now in libc
      ]
    when DARWIN_PLATFORM_REGEX
      [
        "/usr/lib/libSystem.B.dylib",
        "/usr/lib/liblzma.5.dylib",
        "/usr/lib/libobjc.A.dylib",
      ]
    else
      raise "CrossRuby.allowed_dlls: unmatched platform: #{platform}"
    end
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

def verify_dll(dll, cross_ruby)
  allowed_imports = cross_ruby.allowed_dlls
  dump = `#{["env", "LANG=C", cross_ruby.tool("objdump"), "-p", dll].shelljoin}`

  if cross_ruby.windows?
    raise "unexpected file format for generated dll #{dll}" unless /file format #{Regexp.quote(cross_ruby.target_file_format)}\s/ === dump
    raise "export function Init_nokogiri not in dll #{dll}" unless /Table.*\sInit_nokogiri\s/mi === dump

    # Verify that the DLL dependencies are all allowed.
    actual_imports = dump.scan(/DLL Name: (.*)$/).map(&:first).map(&:downcase).uniq
    if !(actual_imports - allowed_imports).empty?
      raise "unallowed so imports #{actual_imports.inspect} in #{dll} (allowed #{allowed_imports.inspect})"
    end

  elsif cross_ruby.linux?
    nm = `#{["env", "LANG=C", cross_ruby.tool("nm"), "-D", dll].shelljoin}`

    raise "unexpected file format for generated dll #{dll}" unless /file format #{Regexp.quote(cross_ruby.target_file_format)}\s/ === dump
    raise "export function Init_nokogiri not in dll #{dll}" unless / T Init_nokogiri/ === nm

    # Verify that the DLL dependencies are all allowed.
    actual_imports = dump.scan(/NEEDED\s+(.*)/).map(&:first).uniq
    if !(actual_imports - allowed_imports).empty?
      raise "unallowed so imports #{actual_imports.inspect} in #{dll} (allowed #{allowed_imports.inspect})"
    end

    # Verify that the expected so version requirements match the actual dependencies.
    ref_versions_data = dump.scan(/0x[\da-f]+ 0x[\da-f]+ \d+ (\w+)_([\d\.]+)$/i)
    # Build a hash of library versions like {"LIBUDEV"=>"183", "GLIBC"=>"2.17"}
    actual_ref_versions = ref_versions_data.each.with_object({}) do |(lib, ver), h|
      if !h[lib] || ver.split(".").map(&:to_i).pack("C*") > h[lib].split(".").map(&:to_i).pack("C*")
        h[lib] = ver
      end
    end
    if actual_ref_versions != cross_ruby.dll_ref_versions
      raise "unexpected so version requirements #{actual_ref_versions.inspect} in #{dll}"
    end

  elsif cross_ruby.darwin?
    nm = `#{["env", "LANG=C", cross_ruby.tool("nm"), "-g", dll].shelljoin}`

    raise "unexpected file format for generated dll #{dll}" unless /file format #{Regexp.quote(cross_ruby.target_file_format)}\s/ === dump
    raise "export function Init_nokogiri not in dll #{dll}" unless / T _?Init_nokogiri/ === nm

    # if liblzma is being referenced, let's make sure it's referring
    # to the system-installed file and not the homebrew-installed file.
    ldd = `#{["env", "LANG=C", cross_ruby.tool("otool"), "-L", dll].shelljoin}`
    if liblzma_refs = ldd.scan(/^\t([^ ]+) /).map(&:first).uniq.grep(/liblzma/)
      liblzma_refs.each do |ref|
        new_ref = File.join("/usr/lib", File.basename(ref))
        sh ["env", "LANG=C", cross_ruby.tool("install_name_tool"), "-change", ref, new_ref, dll].shelljoin
      end

      # reload!
      ldd = `#{["env", "LANG=C", cross_ruby.tool("otool"), "-L", dll].shelljoin}`
    end

    # Verify that the DLL dependencies are all allowed.
    ldd = `#{["env", "LANG=C", cross_ruby.tool("otool"), "-L", dll].shelljoin}`
    actual_imports = ldd.scan(/^\t([^ ]+) /).map(&:first).uniq
    if !(actual_imports - allowed_imports).empty?
      raise "unallowed so imports #{actual_imports.inspect} in #{dll} (allowed #{allowed_imports.inspect})"
    end
  end
  puts "verify_dll: #{dll}: passed shared library sanity checks"
end

CROSS_RUBIES.each do |cross_ruby|
  task cross_ruby.dll_staging_path do |t|
    verify_dll t.name, cross_ruby
  end
end

def gem_builder(plat)
  # use Task#invoke because the pkg/*gem task is defined at runtime
  Rake::Task["native:#{plat}"].invoke
  Rake::Task["pkg/#{GEMSPEC.full_name}-#{Gem::Platform.new(plat).to_s}.gem"].invoke
end

namespace "gem" do
  CROSS_RUBIES.find_all { |cr| cr.windows? || cr.linux? || cr.darwin? }.map(&:platform).uniq.each do |plat|
    pre_req = case plat
              when /\linux/
                "sudo yum install -y git"
              else
                "sudo apt-get update -y && sudo apt-get install -y automake autoconf libtool build-essential"
              end
    desc "build native gem for #{plat} platform"
    task plat do
      RakeCompilerDock.sh <<~EOT, platform: plat
        #{pre_req} &&
        gem install bundler --no-document &&
        bundle &&
        bundle exec rake gem:#{plat}:builder MAKE='nice make -j`nproc`'
      EOT
    end

    namespace plat do
      desc "build native gem for #{plat} platform (guest container)"
      task "builder" do
        gem_builder(plat)
      end
      task "guest" => "builder" # TODO: remove me after this code is on master, temporary backwards compat for CI
    end
  end

  desc "build native gems for windows"
  multitask "windows" => CROSS_RUBIES.find_all(&:windows?).map(&:platform).uniq

  desc "build native gems for linux"
  multitask "linux" => CROSS_RUBIES.find_all(&:linux?).map(&:platform).uniq

  desc "build native gems for darwin"
  multitask "darwin" => CROSS_RUBIES.find_all(&:darwin?).map(&:platform).uniq
end

namespace "native" do
  plat = "x86_64-darwin"
  namespace plat do
    desc "build native gem for #{plat} platform on host OS"
    task "builder" do
      gem_builder(plat)
    end
    task "guest" => "builder" # TODO: remove me after this code is on master, temporary backwards compat for CI
  end
end

require "rake/extensiontask"

Rake::ExtensionTask.new("express_parser", GEMSPEC) do |ext|
  ext.ext_dir = "ext/express-parser"
  ext.lib_dir = File.join(*['lib', 'expressir', 'express', ENV['FAT_DIR']].compact)
  ext.config_options << ENV['EXTOPTS']
  ext.cross_compile  = true
  ext.cross_platform = CROSS_RUBIES.map(&:platform).uniq
  ext.cross_config_options << "--enable-cross-build"
  ext.cross_compiling do |spec|
    spec.files.reject! { |path| File.fnmatch?('ext/*', path) }
    spec.dependencies.reject! { |dep| dep.name == 'rice' }
  end
end
