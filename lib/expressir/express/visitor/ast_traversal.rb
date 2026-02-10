# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module AstTraversal
        # Visit an AST node with the given name
        # @param ast [Hash] The AST node to visit
        # @param name [Symbol] The name of the node
        # @return [Object] The result of visiting the node
        def visit_ast(ast, name)
          ctx = to_ctx(ast, name)

          visit ctx
        end

        private

        # Visit the top-level syntax node
        # @param ctx [Ctx] The context containing the syntax node
        # @return [Object] The result of visiting the syntax node
        def visit_top(ctx)
          visit ctx.syntax
        end

        # Visit a context if it exists, otherwise return a default value
        # @param ctx [Ctx, nil] The context to visit
        # @param default [Object] The default value to return if ctx is nil
        # @return [Object] The result of visiting ctx or the default value
        def visit_if(ctx, default = nil)
          if ctx
            visit(ctx)
          else
            default
          end
        end

        # Visit all items in a context array, or return empty array if nil
        # @param ctx [Array<Ctx>, nil] The context array to visit
        # @return [Array<Object>] The results of visiting each item
        def visit_if_map(ctx)
          if ctx
            ctx.map { |ctx2| visit(ctx2) }
          else
            []
          end
        end

        # Visit all items in a context array and flatten the results
        # @param ctx [Array<Ctx>, nil] The context array to visit
        # @return [Array<Object>] The flattened results of visiting each item
        def visit_if_map_flatten(ctx)
          if ctx
            ctx.map { |ctx2| visit(ctx2) }.flatten
          else
            []
          end
        end
      end
    end
  end
end
