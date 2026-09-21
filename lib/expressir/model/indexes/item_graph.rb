# frozen_string_literal: true

module Expressir
  module Model
    module Indexes
      # Item-level graph over a resolved repository: nodes are schema
      # items (canonical "schema.item" paths), edges are inheritance,
      # interface imports, and attribute-type references.
      #
      # {Model::ModelElement#path} is file-qualified and empty for
      # id-less nodes, so node identity is the last two path segments —
      # unique because schema names are unique within a repository.
      class ItemGraph
        attr_reader :nodes, :subtype_of, :dependencies

        # @param repository [Repository] a resolved repository
        def initialize(repository)
          @nodes = {}
          @subtype_of = Hash.new { |h, k| h[k] = [] }
          @dependencies = Hash.new { |h, k| h[k] = [] }
          build(repository)
        end

        def include?(path)
          @nodes.key?(canonical(path))
        end

        # Transitive supertype closure of an entity, breadth-first.
        def supertypes(path)
          key = canonical(path)
          return [] unless @nodes.key?(key)

          seen = {}
          result = []
          queue = @subtype_of[key].dup
          until queue.empty?
            current = queue.shift
            next if seen[current]

            seen[current] = true
            result << current
            queue.concat(@subtype_of[current])
          end
          result
        end

        # Schemas whose items `schema` imports (USE FROM / REFERENCE
        # FROM), direct only.
        def dependencies_of(schema)
          @dependencies[schema.id.safe_downcase].dup
        end

        def subtype_edges
          @subtype_of.flat_map { |child, parents| parents.map { |p| [child, p] } }
        end

        def cross_schema_subtype_edges
          subtype_edges.count { |child, parent| child.split(".")[0] != parent.split(".")[0] }
        end

        private

        def canonical(path)
          return nil unless path

          parts = path.to_s.split(".")
          return nil if parts.size < 2

          parts[-2, 2].join(".").safe_downcase
        end

        def build(repository)
          repository.schemas.each do |schema|
            schema_id = schema.id.safe_downcase
            schema.entities.to_a.each do |entity|
              key = canonical(entity.path) || "#{schema_id}.#{entity.id.safe_downcase}"
              @nodes[key] = entity
              entity.subtype_of.to_a.each do |ref|
                parent = ref.base_path ? canonical(ref.base_path) : "#{schema_id}.#{ref.id.safe_downcase}"
                @subtype_of[key] << parent if parent
              end
            end
            schema.types.to_a.each do |type|
              key = canonical(type.path) || "#{schema_id}.#{type.id.safe_downcase}"
              @nodes[key] = type
            end
            schema.interfaces.to_a.each do |interface|
              target = interface.schema.is_a?(String) ? interface.schema : interface.schema&.id
              next unless target

              @dependencies[schema_id] << target.safe_downcase
            end
          end
        end
      end
    end
  end
end
