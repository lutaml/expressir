# frozen_string_literal: true

begin
    # native precompiled gems package shared libraries in <gem_dir>/lib/nokogiri/<ruby_version>
    ::RUBY_VERSION =~ /(\d+\.\d+)/
    require_relative "#{Regexp.last_match(1)}/express_parser"
  rescue LoadError => e
#    if /musl/.match?(RUBY_PLATFORM)
#      warn(<<~EOM)
#  
#        ERROR: It looks like you're trying to use Expressir as a precompiled native gem on a musl system.
#  
#          #{e.message}
#  
#          If that's the case, then please install Expressir via the `ruby` platform gem:
#              gem install expressir --platform=ruby
#          or:
#              bundle config set force_ruby_platform true
#  
#  
#      EOM
#      raise e
#    end
  
    # use "require" instead of "require_relative" because non-native gems will place C extension files
    # in Gem::BasicSpecification#extension_dir after compilation (during normal installation), which
    # is in $LOAD_PATH but not necessarily relative to this file
    require "expressir/express/express_parser"
  end
  