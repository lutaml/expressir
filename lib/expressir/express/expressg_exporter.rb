# frozen_string_literal: true

require "json"

module Expressir
  module Express
    # Exports an EXPRESS schema to a Diagram Interchange Model (DIM) 0.1
    # document — the graph the Etassia engine lays out and draws
    # (expressir#671), following the Lutaml::Xsd::DimExporter formation.
    # Entities and SELECT types are nodes (every attribute rides the
    # node as a member block, OPTIONAL folding to "?" like the XSD
    # occurrence suffix), SUBTYPE OF references are generalization
    # edges, DERIVE attributes are association edges, and INVERSE
    # attributes are reference edges to their source entity. The
    # emitter sets no positions; the engine computes them.
    #
    # Recorded losses (v0.1): only entities and SELECT types are nodes
    # — enumeration and simple types ride their referencing members'
    # verbatim type text instead (the XSD built-in-types rule); edges
    # only target nodes that exist in the graph, so a supertype or
    # attribute type from another schema (USE FROM) drops its edge;
    # SUPERTYPE OF expressions (ABSTRACT SUPERTYPE subtyping) are not
    # drawn; WHERE rules and uniqueness constraints are not drawn.
    class ExpressgExporter
      DIM_VERSION = "0.1"
      NOTATION = "express-g"
      WIDTH = 220
      NODE_KIND_PREFIXES = %w[entity type].freeze

      def initialize(schema)
        @schema = schema
      end

      # The DIM document as a Hash conforming to dim-0.1.schema.json.
      def export
        {
          "dim" => DIM_VERSION,
          "notation" => NOTATION,
          "graph" => {
            "id" => graph_id,
            "layoutOptions" => {
              "elk.algorithm" => "layered",
              "elk.direction" => "DOWN",
            },
            "children" => nodes,
            "edges" => edges,
          },
        }
      end

      # The document as JSON, ready for Etassia::Native.render_dim.
      def export_json
        JSON.pretty_generate(export)
      end

      private

      def graph_id
        "schema-#{@schema&.id}"
      end

      def nodes
        entity_nodes + select_nodes
      end

      def entity_nodes
        entities.map { |entity| entity_node(entity) }
      end

      def entity_node(entity)
        content = [
          label(entity.id, "title"),
          label("ENTITY", "stereotype"),
        ]
        content.concat(attribute_members(entity))
        node("entity-#{entity.id}", content)
      end

      def select_nodes
        types.filter_map do |type|
          select = read(type.underlying_type)
          next unless select.is_a?(Model::DataTypes::Select)

          content = [
            label(type.id, "title"),
            label("SELECT", "stereotype"),
          ]
          items = Array(read(select.items))
          content.concat(items.filter_map do |item|
            item_id = read(item.respond_to?(:id) ? item.id : item)
            label(item_id.to_s, "member") if item_id
          end)
          node("type-#{type.id}", content)
        end
      end

      def attribute_members(entity)
        Array(read(entity.attributes)).filter_map do |attribute|
          name = read(attribute.id)
          type_text = read(attribute.type)&.source
          next unless name && type_text

          text = "#{name}#{optional_suffix(attribute)}: #{type_text}"
          case read(attribute.kind)
          when Model::Declarations::Attribute::DERIVED
            label("DERIVE #{text}", "member")
          when Model::Declarations::Attribute::INVERSE
            label("INVERSE #{text}", "member")
          else
            label(text, "member")
          end
        end
      end

      def optional_suffix(attribute)
        read(attribute.optional) ? "?" : ""
      end

      def edges
        node_ids = nodes.map { |n| n["id"] }

        generalization_edges(node_ids) +
          attribute_edges(node_ids) +
          select_edges(node_ids)
      end

      # SUBTYPE OF (supertype[, ...]): a generalization edge per
      # reference that names a node in this graph.
      def generalization_edges(node_ids)
        entities.flat_map do |entity|
          Array(read(entity.subtype_of)).filter_map.with_index do |ref, i|
            target = read(ref.respond_to?(:id) ? ref.id : ref)
            next unless target && node_ids.include?("entity-#{target}")

            edge("subtype-#{entity.id}-#{i}", "entity-#{entity.id}",
                 "entity-#{target}", "generalization")
          end
        end
      end

      # DERIVE attributes draw association edges; INVERSE attributes
      # draw reference edges to their source entity. Attributes whose
      # type names no node ride their member text instead.
      def attribute_edges(node_ids)
        entities.flat_map do |entity|
          Array(read(entity.attributes)).filter_map do |attribute|
            kind = read(attribute.kind)
            next unless [Model::Declarations::Attribute::DERIVED,
                         Model::Declarations::Attribute::INVERSE].include?(kind)

            target = type_ref(read(attribute.type))
            target_id = target && "entity-#{target}"
            next unless target_id && node_ids.include?(target_id)

            name = read(attribute.id)
            style = kind == Model::Declarations::Attribute::INVERSE ? "reference" : "association"
            edge("#{kind.to_s.downcase}-#{entity.id}-#{name}",
                 "entity-#{entity.id}", target_id, style)
          end
        end
      end

      # Select items referencing a graph node draw association edges —
      # the select type's membership of the named type.
      def select_edges(node_ids)
        types.filter_map do |type|
          select = read(type.underlying_type)
          next unless select.is_a?(Model::DataTypes::Select)

          Array(read(select.items)).filter_map do |item|
            item_id = read(item.respond_to?(:id) ? item.id : item)
            target = item_id && NODE_KIND_PREFIXES.find do |prefix|
              node_ids.include?("#{prefix}-#{item_id}")
            end
            next unless target

            edge("select-#{type.id}-#{item_id}", "type-#{type.id}",
                 "#{target}-#{item_id}", "association")
          end
        end.flatten
      end

      # The entity or type name an attribute's type ultimately
      # references: aggregations resolve through base_type; built-ins
      # carry no reference.
      def type_ref(type)
        node = read(type)
        while node
          return read(node.id) if node.is_a?(Model::References::SimpleReference)

          node = node.respond_to?(:base_type) ? read(node.base_type) : nil
        end
        nil
      end

      def node(id, content)
        {
          "id" => id,
          "width" => WIDTH,
          "height" => 24 + (22 * content.length),
          "content" => content,
        }
      end

      def edge(id, source, target, style)
        {
          "id" => id,
          "sources" => [source],
          "targets" => [target],
          "style" => style,
        }
      end

      def label(text, role)
        { "kind" => "label", "text" => text, "role" => role }
      end

      # Reopened model attributes read back as an uninitialized sentinel
      # rather than nil; everything goes through this guard.
      def read(value)
        return nil if value.nil?
        return nil if defined?(Lutaml::Model::Utils) &&
          Lutaml::Model::Utils.respond_to?(:uninitialized?) &&
          Lutaml::Model::Utils.uninitialized?(value)

        value
      end

      def entities
        Array(read(@schema&.entities))
      end

      def types
        Array(read(@schema&.types))
      end
    end
  end
end
