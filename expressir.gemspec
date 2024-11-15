lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "expressir/version"

Gem::Specification.new do |spec|
  spec.name = "expressir"
  spec.version = Expressir::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com"]

  spec.summary = "EXPRESS parser and toolkit for Ruby"
  spec.description = "Expressir (“EXPRESS in Ruby”) is a Ruby parser for EXPRESS and a set of tools for accessing EXPRESS data models."

  spec.homepage = "https://github.com/lutaml/expressir"
  spec.license = "BSD-2-Clause"

  spec.bindir = "exe"
  spec.require_paths = ["lib"]
  spec.executables   = %w[expressir]
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/lutaml/expressir/releases"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.test_files = `git ls-files -- {spec}/*`.split("\n")

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.extensions = File.join(*%w(ext express_parser extconf.rb))

  spec.add_dependency "thor", "~> 1.0"
  spec.add_dependency "parslet", "~> 2.0"
  spec.add_runtime_dependency "rice", "~> 4.2"
  spec.add_runtime_dependency "liquid"
  spec.add_development_dependency "antlr4-native", "~> 2.2"
  spec.add_development_dependency "asciidoctor", "~> 2.0.13"
  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rake-compiler", "~> 1.2"
  spec.add_development_dependency "rake-compiler-dock", "~> 1.5"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rubocop", "1.58"
  spec.add_development_dependency "rubocop-performance", "~> 1.19"
  spec.add_development_dependency "webrick", "~> 1.7.0"
  spec.add_development_dependency "yard", "~> 0.9.26"
end
