# frozen_string_literal: true

module Expressir
  module P21
    # Facade: parse an ISO 10303-21 exchange structure into a
    # {Population} (TODO.eengine/06 step 1).
    #
    # The grammar ships as a compiled PARG artifact
    # (+iso-10303-21.artifact.json+, the checksummed single source of
    # truth shared with expressir-rs; issue #625). The artifact is the
    # only lane: the ruby DSL grammar retired once the artifact lane
    # had a release cycle behind it (2.4.66/2.4.67), and the baked
    # DSL trees (spec/fixtures/p21/conformance/*.tree.json) pin the
    # replay byte-for-byte.
    module Parser
      module_function

      def parse(source)
        Builder.build(artifact_tree(source))
      end

      def artifact_tree(source)
        artifact.parse("exchange_structure", source)
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
