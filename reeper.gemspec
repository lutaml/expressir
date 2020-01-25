lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "reeper/version"

Gem::Specification.new do |spec|
  spec.name          = "reeper"
  spec.version       = Reeper::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com'"]

  spec.summary       = "Ruby tools for harvesting ISO EXPRESS data models."
  spec.description   = "Ruby tools for harvesting ISO EXPRESS data models."
  spec.homepage      = "https://github.com/metanorma/reeper"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/metanorma/reeper/releases"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")

  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.executables   = %w[reeper]

  spec.add_runtime_dependency "thor", "~> 1.0"
  spec.add_runtime_dependency "activesupport", "~> 6.0"
  spec.add_development_dependency "nokogiri", "~> 1.10"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
