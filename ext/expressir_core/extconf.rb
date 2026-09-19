# frozen_string_literal: true

require "mkmf"

# The Rust extension only builds against MRI's C API. Other engines
# fall back to the pure-Ruby parser path and must install cleanly.
if RUBY_ENGINE != "ruby" || ENV["EXPRESSIR_CORE"] == "0"
  File.write("Makefile", dummy_makefile("").to_s)
  warn "expressir: skipping the Rust core extension on #{RUBY_ENGINE}"
  exit 0
end

require "rb_sys/mkmf"

create_rust_makefile("expressir/expressir_core") do |r|
  r.profile = ENV.fetch("RB_SYS_CARGO_PROFILE", :dev).to_sym
  r.use_stable_api_compiled_fallback = true
  r.force_install_rust_toolchain = false
end
