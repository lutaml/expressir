# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "canon"
gem "irb"
# CONTROL (#487): replay the 2026-09-23 last-green resolution - lutaml-model from git at
# f2c9a40 ("Bump lutaml-model to 0.8.57"), which drags the old moxml/leptris/yeptris set
# (0.5.79 / 1.9.231 / 0.6.19.1) that loaded green on windows CI. Diagnostic only.
gem "lutaml-model", github: "lutaml/lutaml-model", ref: "f2c9a40db072"
gem "openssl", "~> 3.0"
gem "rake"
gem "rake-compiler"
gem "rspec"
gem "rubocop"
gem "rubocop-performance"
gem "rubocop-rake"
gem "rubocop-rspec"
gem "yard"
