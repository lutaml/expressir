# frozen_string_literal: true

module Expressir
  module P21
    # Facade: parse an ISO 10303-21 exchange structure into a
    # {Population} (TODO.eengine/06 step 1).
    #
    # The grammar ships as a compiled PARG artifact
    # (+iso-10303-21.artifact.json+, the checksummed single source of
    # truth shared with expressir-rs; issue #625): parsing runs through
    # the artifact when it loads, with the DSL grammar as the fallback
    # lane. The parity spec pins the two lanes byte-identically on the
    # annex corpus.
    module Parser
      module_function

      def parse(source)
        tree = artifact_tree(source) || Grammar.new.parse(source)
        Builder.build(tree)
      end

      def artifact_tree(source)
        artifact.parse("exchange_structure", source)
      rescue Parsanol::PARG::ArtifactError
        # The artifact itself is unusable (shape/edition/binding drift):
        # fall back to the DSL grammar lane. A genuine ParseFailed from
        # a valid artifact propagates — malformed input fails loudly on
        # both lanes.
        nil
      end

      def artifact
        @artifact ||= begin
          require "parsanol"
          Parsanol::PARG::Artifact.load(
            Expressir.root_path.join("lib/expressir/p21/iso-10303-21.artifact.json").to_s,
          )
        end
      end
    end
  end
end
