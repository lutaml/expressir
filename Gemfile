# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "canon"
gem "irb"
gem "lutaml-model", "0.8.76" # dev pin: newer lines require yeptris >= 0.6.31 (see the yeptris pin below, #487)
gem "openssl", "~> 3.0"
gem "rake"
gem "rake-compiler"
# yeptris mingw hang (#487): builds 0.6.20+ hang at FFI attach on
# windows (the last-green run of 2026-09-23 resolved 0.6.19.1; the
# published scheme is 4-segment). Dev-bundle pins until a yeptris
# release fixes the mingw build; the expressir gemspec carries no
# yeptris constraint of its own. The lutaml-model pin at the top of
# this group exists because newer lines require yeptris >= 0.6.31.
gem "rspec"
gem "rubocop"
gem "rubocop-performance"
gem "rubocop-rake"
gem "rubocop-rspec"
gem "yard"
# yeptris mingw hang (#487): builds 0.6.20+ hang at FFI attach on
# windows (the last-green run of 2026-09-23 resolved 0.6.19.1; the
# published scheme is 4-segment). Dev-bundle pin until a yeptris
# release fixes the mingw build; the expressir gemspec carries no
# yeptris constraint of its own. The lutaml-model pin at the top of
# this group exists because newer lines require yeptris >= 0.6.31.
gem "yeptris", "~> 0.6.19.0"

# parsanol 1.3.88 (trivia units as positioned Slices) is the line the
# windows-rake 6h hang (#487) is being verified against; CI resolves
# the gemspec constraint (~> 1.3.9, >= 1.3.9) to it automatically.
