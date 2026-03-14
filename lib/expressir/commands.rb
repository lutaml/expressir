# lib/expressir/commands.rb
module Expressir
  module Commands
    autoload :Base, "#{__dir__}/commands/base"
    autoload :Benchmark, "#{__dir__}/commands/benchmark"
    autoload :BenchmarkCache, "#{__dir__}/commands/benchmark_cache"
    autoload :Clean, "#{__dir__}/commands/clean"
    autoload :Coverage, "#{__dir__}/commands/coverage"
    autoload :Format, "#{__dir__}/commands/format"
    autoload :Validate, "#{__dir__}/commands/validate"
    autoload :ValidateLoad, "#{__dir__}/commands/validate_load"
    autoload :ValidateAscii, "#{__dir__}/commands/validate_ascii"
    autoload :Changes, "#{__dir__}/commands/changes"
    autoload :ChangesValidate, "#{__dir__}/commands/changes_validate"
    autoload :ChangesImportEengine, "#{__dir__}/commands/changes_import_eengine"
    autoload :Version, "#{__dir__}/commands/version"
    autoload :Package, "#{__dir__}/commands/package"
    autoload :Manifest, "#{__dir__}/commands/manifest"
  end
end
