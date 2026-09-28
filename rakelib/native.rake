# frozen_string_literal: true

# Prebuilt platform gems (TODO.suma-improvements/01): the compiled Rust
# core ships inside per-platform gems, mirroring the parsanol-ruby
# pattern (RbSys::ExtensionTask + cross_compiling staging). The source
# gem keeps its gemspec-declared extconf build; platform gems carry the
# artifact in lib/expressir/, which core.rb's first require finds.
begin
  require "rb_sys/extensiontask"
  require "rb_sys/toolchain_info"

  gemspec = Gem::Specification.load("expressir.gemspec")

  RbSys::ExtensionTask.new("expressir_core", gemspec) do |ext|
    ext.lib_dir = "lib/expressir"

    ext.cross_compiling do |spec|
      next if spec.platform == Gem::Platform::RUBY

      plat = spec.platform.to_s
      triple = begin
        RbSys::ToolchainInfo::DATA.fetch(plat).fetch("rust-target")
      rescue KeyError
        { "arm-linux-musl" => "arm-unknown-linux-musleabihf" }.fetch(plat)
      end

      # rb-sys's cargo build already ran for the cross target; stage the
      # artifact from the tree (rake-compiler stages callback-added files).
      # rb_sys uses a per-package target dir unless the crate is a
      # workspace member (then the root target/ holds artifacts) — glob
      # both layouts.
      art = Dir["target/#{triple}/release/expressir_core.{so,dylib,dll}",
                "target/#{triple}/release/libexpressir_core.{so,dylib}",
                "ext/expressir_core/target/#{triple}/release/expressir_core.{so,dylib,dll}",
                "ext/expressir_core/target/#{triple}/release/libexpressir_core.{so,dylib}"].first
      raise "binding artifact not found for #{plat} (#{triple})" unless art

      # core.rb requires "expressir/expressir_core", so the staged file
      # must sit at the canonical Ruby extension path/name — cargo's
      # lib- prefixed or .dll/.dylib-suffixed names are renamed to
      # expressir_core.so (Ruby's require accepts .so on every target:
      # DLEXT on linux/windows, DLEXT2 on darwin).
      dest = "lib/expressir/expressir_core.so"
      cp art, dest
      spec.files << dest
    end
  end
rescue LoadError
  # rake-compiler/rb_sys not installed (consumer checkouts); the native
  # gem tasks are a maintainer/CI concern only.
end
