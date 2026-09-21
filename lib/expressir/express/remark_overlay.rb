# frozen_string_literal: true

module Expressir
  module Express
    # Remarks are deterministic given the sources, so the batch path
    # persists them as an overlay next to the compiled-set artifact;
    # warm loads re-apply the overlay instead of re-running the
    # {RemarkAttacher}.
    #
    # Nodes are keyed structurally — attribute path plus array index —
    # because {Model::ModelElement#path} is empty for id-less nodes
    # (statements), and the wire is byte-identical between the cold
    # write and the warm apply, so structural keys match exactly.
    module RemarkOverlay
      CAPTURED = %w[remarks remark_items informal_propositions untagged_remarks header].freeze

      class << self
        # Mirrors {ModelVisitor} traversal (every typed attribute,
        # statements included), threading a structural key.
        def each_node(node, key, &block)
          yield node, key
          return unless node.is_a?(Model::ModelElement)

          node.class.attributes.each_key do |attr|
            next if Model::ModelElement::SKIP_ATTRIBUTES.include?(attr)

            value = node.public_send(attr)
            case value
            when Array
              value.each_with_index do |item, index|
                next unless item.is_a?(Model::ModelElement)

                each_node(item, "#{key}/#{attr}[#{index}]", &block)
              end
            when Model::ModelElement
              each_node(value, "#{key}/#{attr}", &block)
            end
          end
        end

        def write(set_path, models)
          overlay = {}
          models.each_with_index do |model, index|
            each_node(model, "model[#{index}]") do |node, key|
              entry = {}
              CAPTURED.each do |attr|
                next unless node.respond_to?(attr)

                value = node.public_send(attr)
                entry[attr] = value if attr == "header" ? value : value&.any?
              end
              overlay[key] = entry if entry.any?
            end
          end
          return if overlay.empty?

          require "json"
          File.write("#{set_path}.remarks.json", JSON.generate(overlay))
        end

        def apply(set_path, models)
          overlay_path = "#{set_path}.remarks.json"
          return unless File.exist?(overlay_path)

          require "json"
          overlay = JSON.parse(File.read(overlay_path))
          models.each_with_index do |model, index|
            each_node(model, "model[#{index}]") do |node, key|
              entry = overlay[key]
              next unless entry

              CAPTURED.each do |attr|
                setter = :"#{attr}="
                next unless entry[attr] && node.respond_to?(setter)

                node.public_send(setter, entry[attr])
              end
            end
          end
        end
      end
    end
  end
end
