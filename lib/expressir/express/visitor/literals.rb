# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module Literals
        private

        # Handle binary literal token
        # @param ctx [SimpleCtx] The context containing the binary literal
        # @return [Model::Literals::Binary] The binary literal
        def handle_binary_literal(ctx)
          ctx__text = ctx.text

          value = ctx__text[1..(ctx__text.length - 1)]

          Model::Literals::Binary.new(
            value: value,
          )
        end

        # Handle integer literal token
        # @param ctx [SimpleCtx] The context containing the integer literal
        # @return [Model::Literals::Integer] The integer literal
        def handle_integer_literal(ctx)
          ctx__text = ctx.text

          value = ctx__text

          Model::Literals::Integer.new(
            value: value,
          )
        end

        # Handle real literal token
        # @param ctx [SimpleCtx] The context containing the real literal
        # @return [Model::Literals::Real] The real literal
        def handle_real_literal(ctx)
          ctx__text = ctx.text

          value = ctx__text

          Model::Literals::Real.new(
            value: value,
          )
        end

        # Handle simple ID token
        # @param ctx [SimpleCtx] The context containing the simple ID
        # @return [String] The ID text
        def handle_simple_id(ctx)
          ctx.text
        end

        # Handle simple string literal token
        # @param ctx [SimpleCtx] The context containing the string literal
        # @return [Model::Literals::String] The string literal
        def handle_simple_string_literal(ctx)
          ctx__text = ctx.text

          value = ctx__text[1..(ctx__text.length - 2)].force_encoding("UTF-8")

          Model::Literals::String.new(
            value: value,
          )
        end

        # Handle encoded string literal token
        # @param ctx [SimpleCtx] The context containing the encoded string literal
        # @return [Model::Literals::String] The string literal with encoded flag
        def handle_encoded_string_literal(ctx)
          ctx__text = ctx.text

          value = ctx__text[1..(ctx__text.length - 2)].force_encoding("UTF-8")

          Model::Literals::String.new(
            value: value,
            encoded: true,
          )
        end

        # Visit literal node
        # @param ctx [Ctx] The context containing the literal
        # @return [Model::Literals::*] The appropriate literal object
        def visit_literal(ctx)
          ctx__BinaryLiteral = ctx.binary_literal
          ctx__IntegerLiteral = ctx.integerLiteral
          ctx__logical_literal = ctx.logical_literal
          ctx__RealLiteral = ctx.real_literal
          ctx__string_literal = ctx.string_literal

          if ctx__BinaryLiteral
            handle_binary_literal(ctx__BinaryLiteral)
          elsif ctx__IntegerLiteral
            handle_integer_literal(ctx__IntegerLiteral)
          elsif ctx__logical_literal
            visit(ctx__logical_literal)
          elsif ctx__RealLiteral
            handle_real_literal(ctx__RealLiteral)
          elsif ctx__string_literal
            visit(ctx__string_literal)
          else
            raise Error::VisitorInvalidStateError.new("visit_literal called with invalid context")
          end
        end

        # Visit logical literal node
        # @param ctx [Ctx] The context containing the logical literal
        # @return [Model::Literals::Logical] The logical literal
        def visit_logical_literal(ctx)
          ctx__TRUE = ctx.tTRUE
          ctx__FALSE = ctx.tFALSE
          ctx__UNKNOWN = ctx.tUNKNOWN

          value = if ctx__TRUE
                    Model::Literals::Logical::TRUE
                  elsif ctx__FALSE
                    Model::Literals::Logical::FALSE
                  elsif ctx__UNKNOWN
                    Model::Literals::Logical::UNKNOWN
                  else
                    raise Error::VisitorInvalidStateError.new("visit_logical_literal called with invalid context")
                  end

          Model::Literals::Logical.new(
            value: value,
          )
        end
      end
    end
  end
end
