lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "expressir/version"

Gem::Specification.new do |spec|
  spec.name = "expressir"
  spec.version = Expressir::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com"]

  spec.summary = "EXPRESS parser and toolkit for Ruby"
  spec.description = 'Expressir ("EXPRESS in Ruby") is a Ruby parser for EXPRESS and a set of tools for accessing EXPRESS data models.'

  spec.homepage = "https://github.com/lutaml/expressir"
  spec.license = "BSD-2-Clause"

  spec.bindir = "exe"
  spec.executables   = %w[expressir]
  spec.require_paths = ["lib"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/lutaml/expressir/releases"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.add_dependency "base64"
  spec.add_dependency "benchmark-ips"
  spec.add_dependency "csv"
  spec.add_dependency "liquid"
  spec.add_dependency "lutaml-model"
  spec.add_dependency "parslet", "~> 2.0"
  spec.add_dependency "ruby-progressbar", "~> 1.11"
  spec.add_dependency "table_tennis"
  spec.add_dependency "thor", "~> 1.0"
end
