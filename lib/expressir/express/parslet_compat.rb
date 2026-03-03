# frozen_string_literal: true

# Parslet Compatibility Layer for Parsanol Migration
#
# This file provides backward compatibility for code that uses the original
# Parslet API by aliasing Parslet to Parsanol::Parslet.
#
# Usage:
#   require 'expressir/express/parslet_compat'
#
#   # Now you can use Parslet as before:
#   class MyParser < Parslet::Parser
#     rule(:foo) { str('foo') }
#     root(:foo)
#   end
#
# Migration from original Parslet:
#   Before: require 'parslet'
#   After:  require 'expressir/express/parslet_compat'

require "parsanol"
require "parsanol/parslet"

# Set up Parslet alias for backward compatibility
# This allows existing code to work without changes
unless defined?(Parslet)
  Parslet = Parsanol::Parslet
end

# Ensure Parslet::Native is available if Parsanol::Native is loaded
# (for code that uses the native extension)
if defined?(Parsanol::Native) && !defined?(Parslet::Native)
  module Parslet
    Native = Parsanol::Native
  end
end
