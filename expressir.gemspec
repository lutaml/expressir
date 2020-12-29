lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "expressir/version"

Gem::Specification.new do |spec|
  spec.name          = "expressir"
  spec.version       = Expressir::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com'"]

  spec.summary       = "ISO EXPRESS parser in Ruby, tools for accessing EXPRESS data models."
  spec.description   = "ISO EXPRESS parser in Ruby, tools for accessing EXPRESS data models."
  spec.homepage      = "https://github.com/lutaml/expressir"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/lutaml/expressir/releases"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.files         = `git ls-files`.split("\n")\
    + Dir.glob('ext/express-parser/antlr4-upstream/runtime/Cpp/runtime/**/*')

  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")

  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.executables   = %w[expressir]

  spec.extensions = File.join(*%w(ext express-parser extconf.rb))

  spec.add_runtime_dependency "thor", "~> 1.0"
  spec.add_runtime_dependency "rice", "~> 2.2.0"
  spec.add_development_dependency "antlr4-native", "~> 1.1.0"
  spec.add_development_dependency "nokogiri", "~> 1.10"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler", "~> 1.1.1"
  spec.add_development_dependency "rspec", "~> 3.0"
end
