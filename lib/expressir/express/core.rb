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

      # Parse EXPRESS source into the hydrated model directly: the
      # extension walks the wire definition once and constructs every
      # node through Serializable.instantiate (lutaml-model's fast
      # bulk constructor). Falls back to the hash path when either
      # the extension or the lutaml-model instantiate API is absent.
      def self.parse_to_model(source, path)
        unless ::Expressir::Core.respond_to?(:parse_to_model) &&
            Model::ExpFile.respond_to?(:instantiate)
          raise NotImplementedError,
                "direct model construction unavailable; use parse_to_model_hash"
        end

        ::Expressir::Core.parse_to_model(source, path)
      end

      # Compile many files concurrently: jobs are [read_path,
      # wire_path] pairs; the block receives (wire_path, model, error)
      # per job in completion order. Workers run on native threads, so
      # they keep compiling while the block hydrates and post-processes
      # each model.
      def self.parse_batch(jobs, workers: 0)
        unless ::Expressir::Core.respond_to?(:const_defined?) &&
            ::Expressir::Core.const_defined?(:BatchStream)
          raise NotImplementedError,
                "batch compile unavailable; parse files individually"
        end

        stream = ::Expressir::Core::BatchStream.start(jobs, workers)
        while (item = stream.next)
          path, model, error = item
          yield(path, model, error)
        end
      end
    end
  end
end
