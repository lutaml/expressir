require "set"
require_relative "visitor/remark_attacher"
require_relative "visitor/ast_traversal"
require_relative "visitor/references"
require_relative "visitor/literals"
require_relative "visitor/helpers"
require_relative "visitor/expressions"
require_relative "visitor/types"
require_relative "visitor/statements"
require_relative "visitor/declarations"

# reference type is not recognized
# see note in A.1.5 Interpreted identifiers
# > It is expected that identifiers matching these syntax rules are known to an implementation.
# > How the implementation obtains this information is of no concern to the definition of the language. One
# > method of gaining this information is multi-pass parsing: the first pass collects the identifiers from their
# > declarations, so that subsequent passes are then able to distinguish a veriable_ref from a function_ref,
# > for example.
# - such multi-pass parsing is not implemented yet
# - xxxRef - merged to SimpleReference
# - entityConstructor, functionCall - merged to FunctionCall
#
# difference between generalized and instantiable types is not recognized
# see note in 8.6.2 Parameter data types
# > A syntactic construct such as ARRAY[1:3] OF REAL satisfies two syntactic productions —
# > aggregation_type and general_aggregation_type. It is considered to be instantiable no matter which
# > production it is required to satisfy in the syntax.
#
# static shorthands are unwrapped
# - entity attributes, function/procedure parameters, local variables
#
# all access to ctx members must happen before calling other visitor code
# - prevents segfault in ANTLR4 C++ runtime, not sure why they are caused
# - e.g. see visit_schema_decl

module Expressir
  module Express
    class Visitor
      class Ctx
        attr_reader :name, :data
        attr_accessor :source_pos

        def initialize(data, name)
          @data = data
          @name = name
        end

        def text
          str.data.to_s
        end

        def method_missing(name, *args)
          rulename = name.to_s.sub(/^visit_/, "").gsub(/_([a-z])/) do |m|
            m[1].upcase
          end.to_sym
          self.class.define_method(name) { @data[rulename] }
          send name, *args
        end

        def keys
          @data.keys
        end

        def values
          @data.values
        end

        def each(&block)
          @data.values.each(&block)
        end
      end

      class SimpleCtx
        attr_reader :name, :data

        def initialize(data, name)
          @data = data
          @name = name
        end

        def text
          @data.to_s
        end
      end

      REMARK_CHANNEL = 2

      private_constant :REMARK_CHANNEL

      # Include visitor modules
      include AstTraversal
      include References
      include Literals
      include Helpers
      include Expressions
      include Types
      include Statements
      include Declarations

      # @param [::ExpressParser::TokenVector] Rice-wrapped std::vector<TokenProxy>
      # @param [Boolean] include_source attach original source code to model elements
      def initialize(source, include_source: nil)
        @source = source
        @include_source = include_source

        @attached_remark_tokens = Set.new
        
        # Create remark attacher with proc for getting source position
        @remark_attacher = RemarkAttacher.new(
          @source,
          @attached_remark_tokens,
          ->(ctx) { get_source_pos(ctx) }
        )

        @visit_methods = private_methods.grep(/^visit_/).to_h do |name|
          rulename = name.to_s.sub(/^visit_/, "").gsub(/_([a-z])/) do
            $1.upcase
          end
          [rulename.to_sym, name.to_sym]
        end
      end

      def to_ctx(ast, name = :unnamed)
        case ast
        when Hash
          nodes = ast.to_h do |k, v|
            if k =~ /^listOf_(.*)$/
              itemkey = $1.to_sym
              ary = Array === v ? v : [v]
              [itemkey, to_ctx(ary.select do |v|
                v[itemkey]
              end.map { |v| v.slice(itemkey) })]
            else
              [k, to_ctx(v, k)]
            end
          end
          Ctx.new nodes, name
        when Array
          ast.map do |element|
            # Each array element should have exactly one key-value pair
            unless element.length == 1
              raise Error::VisitorInvalidInputError.new("Invalid array element: expected single key-value pair, got #{element.keys}")
            end

            # Extract the single key and value
            key = element.keys[0]
            value = element.values[0]

            # Create context with the value and name it after the key
            to_ctx(value, key)
          end
        when nil
          nil
        else
          SimpleCtx.new ast, name
        end
      end

      def get_source_pos(ctx)
        ranges = case ctx
                 when Ctx
                   ctx.source_pos and return ctx.source_pos # cache
                   ctx.values.map { |item| get_source_pos(item) }
                 when SimpleCtx
                   return nil unless ctx.data.respond_to? :offset

                   [[ctx.data.offset, ctx.data.offset + ctx.data.length]]
                 when Array
                   ctx.map { |item| get_source_pos(item) }
                 else
                   raise Error::VisitorInvalidInputError.new("unknown type in Ctx tree: #{ctx}")
                 end
        source_pos = ranges.compact.reduce do |item, acc|
          [[item[0], acc[0]].min, [item[1], acc[1]].max]
        end
        Ctx === ctx and ctx.source_pos = source_pos
        source_pos
      end

      def get_source(ctx)
        a, b = get_source_pos ctx
        @source[a..(b - 1)].strip
      end

      def visit_ast(ast, name)
        ctx = to_ctx(ast, name)

        visit ctx
      end

      def visit(ctx)
        if Array === ctx
          return ctx.map { |el| visit el }
        end

        node = ctx
        if @visit_methods[ctx.name]
          node = send(@visit_methods[ctx.name], ctx)
          if @include_source && node.respond_to?(:source)
            node.source = get_source ctx
          end
        end

        @remark_attacher.attach_remarks(ctx, node)
        node
      end

      private

      def visit_top(ctx)
        visit ctx.syntax
      end

      def visit_if(ctx, default = nil)
        if ctx
          visit(ctx)
        else
          default
        end
      end

      def visit_if_map(ctx)
        if ctx
          ctx.map { |ctx2| visit(ctx2) }
        else
          []
        end
      end

      def visit_if_map_flatten(ctx)
        if ctx
          ctx.map { |ctx2| visit(ctx2) }.flatten
        else
          []
        end
      end





      def visit_syntax(ctx)
        ctx__schema_decl = ctx.schema_decl

        schemas = visit_if_map(ctx__schema_decl)

        Model::Repository.new(
          schemas: schemas,
        )
      end

      def handle_binary_expression(operands, operators)
        if operands.length != operators.length + 1
          raise Error::VisitorInvalidStateError.new("handle_binary_expression called with invalid context")
        end

        expression = Model::Expressions::BinaryExpression.new(
          operator: operators[0],
          operand1: operands[0],
          operand2: operands[1],
        )
        operators[1..(operators.length - 1)].each_with_index do |operator, i|
          expression = Model::Expressions::BinaryExpression.new(
            operator: operator,
            operand1: expression,
            operand2: operands[i + 2],
          )
        end
        expression
      end

      def handle_binary_supertype_expression(operands, operators)
        if operands.length != operators.length + 1
          raise Error::VisitorInvalidStateError.new("handle_binary_supertype_expression called with invalid context")
        end

        expression = Model::SupertypeExpressions::BinarySupertypeExpression.new(
          operator: operators[0],
          operand1: operands[0],
          operand2: operands[1],
        )
        operators[1..(operators.length - 1)].each_with_index do |operator, i|
          expression = Model::SupertypeExpressions::BinarySupertypeExpression.new(
            operator: operator,
            operand1: expression,
            operand2: operands[i + 2],
          )
        end
        expression
      end

      def handle_qualified_ref(ref, qualifiers)
        qualifiers.reduce(ref) do |ref, ctx|
          ctx__attribute_qualifier = ctx.attribute_qualifier
          ctx__group_qualifier = ctx.group_qualifier
          ctx__index_qualifier = ctx.index_qualifier

          if ctx__attribute_qualifier
            attribute_reference = visit_if(ctx__attribute_qualifier)

            Model::References::AttributeReference.new(
              ref: ref,
              attribute: attribute_reference.attribute,
            )
          elsif ctx__group_qualifier
            group_reference = visit_if(ctx__group_qualifier)

            Model::References::GroupReference.new(
              ref: ref,
              entity: group_reference.entity,
            )
          elsif ctx__index_qualifier
            index_reference = visit_if(ctx__index_qualifier)

            Model::References::IndexReference.new(
              ref: ref,
              index1: index_reference.index1,
              index2: index_reference.index2,
            )
          else
            raise Error::VisitorInvalidStateError.new("handle_qualified_ref called with invalid context")
          end
        end
      end

      def handle_binary_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text[1..(ctx__text.length - 1)]

        Model::Literals::Binary.new(
          value: value,
        )
      end

      def handle_integer_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text

        Model::Literals::Integer.new(
          value: value,
        )
      end

      def handle_real_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text

        Model::Literals::Real.new(
          value: value,
        )
      end

      def handle_simple_id(ctx)
        ctx.text
      end

      def handle_simple_string_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text[1..(ctx__text.length - 2)].force_encoding("UTF-8")

        Model::Literals::String.new(
          value: value,
        )
      end

      def handle_encoded_string_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text[1..(ctx__text.length - 2)].force_encoding("UTF-8")

        Model::Literals::String.new(
          value: value,
          encoded: true,
        )
      end
    end
  end
end
