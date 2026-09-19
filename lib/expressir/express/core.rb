# frozen_string_literal: true

require "json"

module Expressir
  module Express
    # Ruby bridge to the expressir-core Rust crate (parse + model
    # extraction). Available when the native extension is built;
    # callers fall back to the pure-Ruby parser otherwise.
    module Core
      NATIVE_AVAILABLE = begin
        require "expressir/expressir_core"
        true
      rescue LoadError
        begin
          require_relative "../../../ext/expressir_core/expressir_core"
          true
        rescue LoadError
          false
        end
      end

      # Parse EXPRESS source and return the model as a plain Hash in the
      # lutaml wire shape (to_hash-compatible), ready for
      # Expressir::Model::ExpFile.from_hash. `path` is the relative file
      # path used for file/base_path wiring in the model.
      def self.parse_to_model_hash(source, path)
        JSON.parse(::Expressir::Core.parse_to_model_hash(source, path))
      end
    end
  end
end
