# frozen_string_literal: true

require_relative "helpers"

module Expressir
  module Express
    module Builders
      # Builds rule declaration nodes.
      class RuleDeclBuilder
        include Helpers

        def call(ast_data)
          head = ast_data[:rule_head]
          algorithm_head = ast_data[:algorithm_head]
          stmts = ast_data[:stmt]
          where_clause = ast_data[:where_clause]

          id = Builder.build_optional(head[:rule_id]) if head
          applies_to = build_applies_to(head)

          declarations = []
          if algorithm_head.is_a?(Hash)
            declarations = Builder.build_children(algorithm_head[:declaration])
          end

          types = declarations.select { |x| x.is_a?(Expressir::Model::Declarations::Type) }
          entities = declarations.select { |x| x.is_a?(Expressir::Model::Declarations::Entity) }
          subtype_constraints = declarations.select { |x| x.is_a?(Expressir::Model::Declarations::SubtypeConstraint) }
          functions = declarations.select { |x| x.is_a?(Expressir::Model::Declarations::Function) }
          procedures = declarations.select { |x| x.is_a?(Expressir::Model::Declarations::Procedure) }
          constants = build_constant_decl(algorithm_head[:constant_decl]) if algorithm_head.is_a?(Hash) && algorithm_head[:constant_decl]
          variables = build_local_decl(algorithm_head[:local_decl]) if algorithm_head.is_a?(Hash) && algorithm_head[:local_decl]
          statements = Builder.build_children(stmts)
          where_rules = where_clause ? Builder.build({ where_clause: where_clause }) : []

          Expressir::Model::Declarations::Rule.new(
            id: id,
            applies_to: [applies_to].flatten.compact,
            types: types,
            entities: entities,
            subtype_constraints: subtype_constraints,
            functions: functions,
            procedures: procedures,
            constants: [constants].flatten.compact,
            variables: [variables].flatten.compact,
            statements: statements.compact,
            where_rules: [where_rules].flatten.compact,
          )
        end

        private

        def build_applies_to(head)
          return [] unless head && head[:list_of_entity_ref]

          entity_refs = head[:list_of_entity_ref]
          refs = []

          # entity_refs can be:
          # - A Hash with entity_ref key (single entity)
          # - An Array of Hashes (multiple entities)
          if entity_refs.is_a?(Array)
            entity_refs.each do |item|
              if item[:entity_ref]
                refs << Builder.build({ entity_ref: item[:entity_ref] })
              end
            end
          elsif entity_refs.is_a?(Hash)
            if entity_refs[:entity_ref]
              refs << Builder.build({ entity_ref: entity_refs[:entity_ref] })
            end
            if entity_refs[:item]
              [entity_refs[:item]].flatten.each do |item|
                if item[:entity_ref]
                  refs << Builder.build({ entity_ref: item[:entity_ref] })
                end
              end
            end
          end
          refs.compact
        end

        def build_constant_decl(data)
          Builder.build_children(data[:constant_body])
        end

        def build_local_decl(data)
          Builder.build_children(data[:local_variable]).flatten.compact
        end
      end
    end
  end
end

Builder.register(:rule_decl, Expressir::Express::Builders::RuleDeclBuilder.new)
