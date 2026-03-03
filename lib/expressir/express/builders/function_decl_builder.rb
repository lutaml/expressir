# frozen_string_literal: true

require_relative "helpers"

module Expressir
  module Express
    module Builders
      # Builds function declaration nodes.
      class FunctionDeclBuilder
        include Helpers

        def call(ast_data)
          head = ast_data[:function_head]
          algorithm_head = ast_data[:algorithm_head]
          stmts = ast_data[:stmt]

          id = Builder.build_optional(head[:function_id]) if head
          parameters = build_parameters(head)
          return_type = Builder.build_optional(head[:parameter_type]) if head

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

          Expressir::Model::Declarations::Function.new(
            id: id,
            parameters: parameters,
            return_type: return_type,
            types: types,
            entities: entities,
            subtype_constraints: subtype_constraints,
            functions: functions,
            procedures: procedures,
            constants: [constants].flatten.compact,
            variables: [variables].flatten.compact,
            statements: statements.compact,
          )
        end

        private

        def build_parameters(head)
          return [] unless head && head[:list_of_formal_parameter]

          params_data = head[:list_of_formal_parameter]
          if params_data.is_a?(Hash) && params_data[:formal_parameter]
            params_data = [params_data[:formal_parameter]]
          elsif params_data.is_a?(Array)
            params_data = params_data.filter_map do |p|
              p[:formal_parameter] if p.is_a?(Hash)
            end
          end

          parameters = []
          params_data.flatten.compact.each do |param|
            result = Builder.build({ formal_parameter: param })
            parameters.concat([result].flatten.compact) if result
          end
          parameters
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

Builder.register(:function_decl, Expressir::Express::Builders::FunctionDeclBuilder.new)
