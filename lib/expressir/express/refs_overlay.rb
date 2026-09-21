# frozen_string_literal: true

module Expressir
  module Express
    # Resolved references are deterministic given the sources and the
    # repository composition, so the batch path persists every
    # SimpleReference's final base_path as an overlay next to the
    # compiled-set artifact; warm loads re-apply them instead of
    # re-running the {ResolveReferencesModelVisitor}.
    module RefsOverlay
      module_function

      def write(set_path, models)
        refs = {}
        ModelTraversal.each_model(models) do |node, key|
          next unless node.is_a?(Model::References::SimpleReference)
          next if node.base_path.nil?

          refs[key] = node.base_path
        end
        return if refs.empty?

        require "json"
        File.write("#{set_path}.refs.json", JSON.generate(refs))
      end

      # Returns true when the overlay was applied (caller then skips
      # the resolver); false when absent — caller falls back to
      # resolving.
      def apply(set_path, models)
        refs_path = "#{set_path}.refs.json"
        return false unless File.exist?(refs_path)

        require "json"
        refs = JSON.parse(File.read(refs_path))
        ModelTraversal.each_model(models) do |node, key|
          next unless node.is_a?(Model::References::SimpleReference)

          base_path = refs[key]
          node.base_path = base_path unless base_path.nil?
        end
        true
      end
    end
  end
end
