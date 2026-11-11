# frozen_string_literal: true

require "json"
require "open3"
require "rubygems/version"

module Expressir
  module Tools
    # The engine-compat manifest checker (expressir#618, mirroring
    # parsanol-rs#423's tools/check_engine_compat.py): ENGINE-COMPAT.json
    # maps the gem train to the expressir-rs ext tag and its engine
    # commit; this verifies the pairings so the train cannot ship with a
    # stale manifest.
    #
    # Checks:
    # 1. The ext pin in ext/expressir_core/Cargo.toml names
    #    manifest["ext"].
    # 2. The tag exists on origin and points at manifest["engine_commit"].
    # 3. rubygems.org serves a version >= manifest["rubygems"] (>= because
    #    CI runs on the bump commit before the tag publish catches up).
    module CheckEngineCompat
      MANIFEST = "ENGINE-COMPAT.json"
      PIN_RE = /expressir-rs = \{ git = "([^"]+)", tag = "([^"]+)" \}/

      module_function

      def failures(root: Dir.pwd)
        manifest = JSON.parse(File.read(File.join(root, MANIFEST)))
        failures = []

        failures.concat(pin_failures(root, manifest))
        failures.concat(tag_failures(root, manifest))
        failures.concat(registry_failures(manifest)) unless manifest["rubygems"].nil?
        failures
      rescue StandardError => e
        ["#{MANIFEST}: #{e.message}"]
      end

      # [git url, tag] straight from the ext pin — the tag lives on the
      # expressir-rs repository, not on expressir's origin.
      def ext_pin(root)
        m = File.read(File.join(root, "ext/expressir_core/Cargo.toml")).match(PIN_RE)
        return unless m

        # ssh and https forms both resolve via ls-remote; normalize to https.
        [m[1].sub(%r{\Agit@github\.com:}, "https://github.com/"), m[2]]
      end

      def pin_failures(root, manifest)
        pin = ext_pin(root)
        return ["ext pin missing from ext/expressir_core/Cargo.toml"] unless pin
        return [] if pin[1] == manifest["ext"]

        ["ext pin #{pin[1].inspect} != manifest ext #{manifest['ext'].inspect}"]
      end

      def tag_failures(root, manifest)
        pin = ext_pin(root)
        return ["ext pin missing from ext/expressir_core/Cargo.toml"] unless pin

        url, tag = pin
        out, status = Open3.capture2("git", "ls-remote", url, "refs/tags/#{tag}")
        return ["git ls-remote failed for #{url}"] unless status.success?

        sha = out[/^([0-9a-f]{40})/, 1]
        return ["tag #{tag.inspect} not found on #{url}"] unless sha

        # annotated (release) tags carry a ^{} peeled entry; either line
        # matching the engine commit passes.
        return [] if out.include?(manifest["engine_commit"])

        ["tag #{tag.inspect} points at #{sha[0, 7]}, " \
         "not engine_commit #{manifest['engine_commit'][0, 7]}"]
      end

      def registry_failures(manifest)
        url = "https://rubygems.org/api/v1/versions/expressir/latest.json"
        out, status = Open3.capture2("curl", "-sf", "--retry", "3", url)
        return ["rubygems query failed"] unless status.success?

        served = JSON.parse(out)["version"]
        return [] if Gem::Version.new(served) >= Gem::Version.new(manifest["rubygems"])

        ["rubygems serves #{served.inspect}, manifest wants >= " \
         "#{manifest['rubygems'].inspect}"]
      end
    end
  end
end
