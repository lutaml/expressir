# frozen_string_literal: true

desc "Property-based conformance harness over the full corpus " \
     "(parse → format → parse idempotence)"
task :conformance do
  ENV["EXPRESSIR_CONFORMANCE"] = "1"
  sh "bundle exec rspec spec/expressir/express/formatter_roundtrip_conformance_spec.rb"
end
