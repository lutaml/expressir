# frozen_string_literal: true

require "digest"
require "fileutils"

ORACLE_TAG = "eeng-5.2.8"
ORACLE_BASE = "https://github.com/expresslang/eengine-releases/releases/download/#{ORACLE_TAG}".freeze
# sha256 pins verified against the release artifacts; add pins for the
# other platforms as they get verified.
ORACLE_ASSETS = {
  %w[darwin arm64] => { asset: "eengine-5.2.8-mac-arm64-sbcl",
                        sha256: "423ecb5bbe401b1c720c526619e4f03f9e64e0dc0fdd134100c35cbfc5e49384" },
  %w[darwin x86_64] => { asset: "eengine-5.2.8-mac-x86-64-sbcl", sha256: nil },
  %w[linux x86_64] => { asset: "eengine-5.2.8-lnx-x86-64-sbcl", sha256: nil },
  %w[linux arm64] => { asset: "eengine-5.2.8-lnx-arm64-sbcl", sha256: nil },
  %w[mingw x86_64] => { asset: "eengine-5.2.8-win-x86-64-sbcl.exe", sha256: nil },
}.freeze

namespace :oracle do
  desc "Fetch the pinned eengine oracle (#{ORACLE_TAG}) into tmp/oracle/eengine " \
       "for the SHTOLO corpus differential"
  task :fetch do
    platform = [Gem::Platform.local.os, Gem::Platform.local.cpu]
    entry = ORACLE_ASSETS[platform]
    abort "no #{ORACLE_TAG} asset for #{platform.join('-')}" unless entry

    target = File.expand_path("../tmp/oracle/eengine", __dir__)
    if File.executable?(target)
      warn "oracle already present: #{target}"
      exit 0
    end

    dir = File.dirname(target)
    mkdir_p dir
    download = File.join(dir, "#{entry[:asset]}.part")
    sh "curl", "-fSL", "-o", download, "#{ORACLE_BASE}/#{entry[:asset]}"
    actual = Digest::SHA256.file(download).hexdigest
    if entry[:sha256]
      unless actual == entry[:sha256]
        rm_f download
        abort "sha256 mismatch for #{entry[:asset]}: got #{actual}, " \
              "expected #{entry[:sha256]}"
      end
    else
      warn "no sha256 pin for #{entry[:asset]}; downloaded artifact is " \
           "#{actual} (record it in rakelib/oracle.rake)"
    end
    mv download, target
    chmod 0o755, target
    puts "oracle ready: #{target}"
  end
end
