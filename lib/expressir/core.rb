# frozen_string_literal: true

module Expressir
  # Ruby bridge to the expressir-core Rust crate (parse + model
  # extraction). Available when the native extension is built;
  # callers fall back to the pure-Ruby parser otherwise.
  module Core
    NATIVE_AVAILABLE = begin
      require "expressir/expressir_core"
      true
    rescue LoadError
      begin
        require_relative "../../ext/expressir_core/expressir_core"
        true
      rescue LoadError
        false
      end
    end
  end
end
