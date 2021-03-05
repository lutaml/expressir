require 'expressir/model'

module Expressir
  module ExpressExp
    class Formatter
      INDENT_CHAR = ' '
      INDENT_WIDTH = 2
      INDENT = INDENT_CHAR * INDENT_WIDTH

      OPERATOR_PRECEDENCE = {
        Model::Expressions::BinaryExpression::EXPONENTIATION => 1,
        Model::Expressions::BinaryExpression::MULTIPLICATION => 2,
        Model::Expressions::BinaryExpression::REAL_DIVISION => 2,
        Model::Expressions::BinaryExpression::INTEGER_DIVISION => 2,
        Model::Expressions::BinaryExpression::MODULO => 2,
        Model::Expressions::BinaryExpression::AND => 2,
        Model::Expressions::BinaryExpression::COMBINE => 2,
        Model::Expressions::BinaryExpression::SUBTRACTION => 3,
        Model::Expressions::BinaryExpression::ADDITION => 3,
        Model::Expressions::BinaryExpression::OR => 3,
        Model::Expressions::BinaryExpression::XOR => 3,
        Model::Expressions::BinaryExpression::EQUAL => 4,
        Model::Expressions::BinaryExpression::NOT_EQUAL => 4,
        Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL => 4,
        Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL => 4,
        Model::Expressions::BinaryExpression::LESS_THAN => 4,
        Model::Expressions::BinaryExpression::GREATER_THAN => 4,
        Model::Expressions::BinaryExpression::INSTANCE_EQUAL => 4,
        Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL => 4,
        Model::Expressions::BinaryExpression::IN => 4,
        Model::Expressions::BinaryExpression::LIKE => 4,
        Model::Expressions::BinaryExpression::ANDOR => 4,
      }

      def self.format(node)
        formatter = self.new
        formatter.format(node)
      end

      def format(node)
        if node.is_a? Model::Attribute
          format_attribute(node)
        elsif node.is_a? Model::Constant
          format_constant(node)
        elsif node.is_a? Model::Entity
          format_entity(node)
        elsif node.is_a? Model::EnumerationItem
          format_enumeration_item(node)
        elsif node.is_a? Model::Function
          format_function(node)
        elsif node.is_a? Model::Interface
          format_interface(node)
        elsif node.is_a? Model::InterfaceItem
          format_interface_item(node)
        elsif node.is_a? Model::Parameter
          format_parameter(node)
        elsif node.is_a? Model::Procedure
          format_procedure(node)
        elsif node.is_a? Model::Repository
          format_repository(node)
        elsif node.is_a? Model::Rule
          format_rule(node)
        elsif node.is_a? Model::Schema
          format_schema(node)
        elsif node.is_a? Model::SubtypeConstraint
          format_subtype_constraint(node)
        elsif node.is_a? Model::Type
          format_type(node)
        elsif node.is_a? Model::Unique
          format_unique(node)
        elsif node.is_a? Model::Variable
          format_variable(node)
        elsif node.is_a? Model::Where
          format_where(node)
        elsif node.is_a? Model::Expressions::AggregateInitializer
          format_expressions_aggregate_initializer(node)
        elsif node.is_a? Model::Expressions::AggregateItem
          format_expressions_aggregate_item(node)
        elsif node.is_a? Model::Expressions::AttributeReference
          format_expressions_attribute_reference(node)
        elsif node.is_a? Model::Expressions::BinaryExpression
          format_expressions_binary_expression(node)
        elsif node.is_a? Model::Expressions::Call
          format_expressions_call(node)
        elsif node.is_a? Model::Expressions::EntityConstructor
          format_expressions_entity_constructor(node)
        elsif node.is_a? Model::Expressions::GroupReference
          format_expressions_group_reference(node)
        elsif node.is_a? Model::Expressions::IndexReference
          format_expressions_index_reference(node)
        elsif node.is_a? Model::Expressions::Interval
          format_expressions_interval(node)
        elsif node.is_a? Model::Expressions::QueryExpression
          format_expressions_query_expression(node)
        elsif node.is_a? Model::Expressions::SimpleReference
          format_expressions_simple_reference(node)
        elsif node.is_a? Model::Expressions::UnaryExpression
          format_expressions_unary_expression(node)
        elsif node.is_a? Model::Literals::Binary
          format_literals_binary(node)
        elsif node.is_a? Model::Literals::Integer
          format_literals_integer(node)
        elsif node.is_a? Model::Literals::Logical
          format_literals_logical(node)
        elsif node.is_a? Model::Literals::Real
          format_literals_real(node)
        elsif node.is_a? Model::Literals::String
          format_literals_string(node)
        elsif node.is_a? Model::Statements::Alias
          format_statements_alias(node)
        elsif node.is_a? Model::Statements::Assignment
          format_statements_assignment(node)
        elsif node.is_a? Model::Statements::Call
          format_statements_call(node)
        elsif node.is_a? Model::Statements::Case
          format_statements_case(node)
        elsif node.is_a? Model::Statements::CaseAction
          format_statements_case_action(node)
        elsif node.is_a? Model::Statements::Compound
          format_statements_compound(node)
        elsif node.is_a? Model::Statements::Escape
          format_statements_escape(node)
        elsif node.is_a? Model::Statements::If
          format_statements_if(node)
        elsif node.is_a? Model::Statements::Null
          format_statements_null(node)
        elsif node.is_a? Model::Statements::Repeat
          format_statements_repeat(node)
        elsif node.is_a? Model::Statements::Return
          format_statements_return(node)
        elsif node.is_a? Model::Statements::Skip
          format_statements_skip(node)
        elsif node.is_a? Model::Types::Aggregate
          format_types_aggregate(node)
        elsif node.is_a? Model::Types::Array
          format_types_array(node)
        elsif node.is_a? Model::Types::Bag
          format_types_bag(node)
        elsif node.is_a? Model::Types::Binary
          format_types_binary(node)
        elsif node.is_a? Model::Types::Boolean
          format_types_boolean(node)
        elsif node.is_a? Model::Types::Enumeration
          format_types_enumeration(node)
        elsif node.is_a? Model::Types::GenericEntity
          format_types_generic_entity(node)
        elsif node.is_a? Model::Types::Generic
          format_types_generic(node)
        elsif node.is_a? Model::Types::Integer
          format_types_integer(node)
        elsif node.is_a? Model::Types::List
          format_types_list(node)
        elsif node.is_a? Model::Types::Logical
          format_types_logical(node)
        elsif node.is_a? Model::Types::Number
          format_types_number(node)
        elsif node.is_a? Model::Types::Real
          format_types_real(node)
        elsif node.is_a? Model::Types::Select
          format_types_select(node)
        elsif node.is_a? Model::Types::Set
          format_types_set(node)
        elsif node.is_a? Model::Types::String
          format_types_string(node)
        else
          STDERR.puts "#{node.class.name} format not implemented"
          ''
        end
      end

      private

      def format_attribute(node)
        [
          *if node.supertype_attribute
            [
              format(node.supertype_attribute),
              ' ',
            ].join('')
          end,
          *if node.supertype_attribute and node.id
            [
              'RENAMED',
              ' '
            ].join('')
          end,
          *if node.id
            [
              node.id,
              ' '
            ].join('')
          end,
          ':',
          *if node.optional
            [
              ' ',
              'OPTIONAL'
            ].join('')
          end,
          ' ',
          format(node.type),
          *if node.kind == Model::Attribute::DERIVED
            [
              ' ',
              ':=',
              ' ',
              format(node.expression)
            ].join('')
          elsif node.kind == Model::Attribute::INVERSE
            [
              ' ',
              'FOR',
              ' ',
              format(node.expression)
            ].join('')
          end,
          ';',
        ].join('')
      end

      def format_constant(node)
        [
          node.id,
          ' ',
          ':',
          ' ',
          format(node.type),
          ' ',
          ':=',
          ' ',
          format(node.expression),
          ';'
        ].join('')
      end

      def format_entity(node)
        explicit_attributes = node.attributes.select{|x| x.kind == Model::Attribute::EXPLICIT}
        derived_attributes = node.attributes.select{|x| x.kind == Model::Attribute::DERIVED}
        inverse_attributes = node.attributes.select{|x| x.kind == Model::Attribute::INVERSE}

        [
          [
            'ENTITY',
            ' ',
            node.id,
            *if node.abstract and !node.supertype_expression
              [
                "\n",
                indent([
                  'ABSTRACT',
                  ' ',
                  'SUPERTYPE'
                ].join(''))
              ].join('')
            end,
            *if node.abstract and node.supertype_expression
              [
                "\n",
                indent([
                  'ABSTRACT',
                  ' ',
                  'SUPERTYPE',
                  ' ',
                  'OF',
                  ' ',
                  '(',
                  format(node.supertype_expression),
                  ')'
                ].join(''))
              ].join('')
            end,
            *if !node.abstract and node.supertype_expression
              [
                "\n",
                indent([
                  'SUPERTYPE',
                  ' ',
                  'OF',
                  ' ',
                  '(',
                  format(node.supertype_expression),
                  ')'
                ].join(''))
              ].join('')
            end,
            *if node.subtype_of.length > 0
              [
                "\n",
                indent([
                  'SUBTYPE',
                  ' ',
                  'OF',
                  ' ',
                  '(',
                  node.subtype_of.map{|x| format(x)}.join(', '),
                  ')'
                ].join(''))
              ].join('')
            end,
            ';'
          ].join(''),
          *if explicit_attributes and explicit_attributes.length > 0
            indent(explicit_attributes.map{|x| format(x)}.join("\n"))
          end,
          *if derived_attributes and derived_attributes.length > 0
            [
              'DERIVE',
              indent(derived_attributes.map{|x| format(x)}.join("\n")),
            ]
          end,
          *if inverse_attributes and inverse_attributes.length > 0
            [
              'INVERSE',
              indent(inverse_attributes.map{|x| format(x)}.join("\n")),
            ]
          end,
          *if node.unique.length > 0
            [
              'UNIQUE',
              indent(node.unique.map{|x| format(x)}.join("\n"))
            ]
          end,
          *if node.where.length > 0
            [
              'WHERE',
              indent(node.where.map{|x| format(x)}.join("\n")),
            ]
          end,
          [
            'END_ENTITY',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_enumeration_item(node)
        node.id
      end

      def format_function(node)
        [
          [
            'FUNCTION',
            ' ',
            node.id,
            *if node.parameters.length > 0
              parameter_indent = INDENT_CHAR * "FUNCTION #{node.id}(".length
              [
                '(',
                node.parameters.map{|x| format(x)}.join(";\n#{parameter_indent}"),
                ')'
              ].join('')
            end,
            ' ',
            ':',
            ' ',
            format(node.return_type),
            ';'
          ].join(''),
          *if node.types.length > 0
            indent(node.types.map{|x| format(x)}.join("\n"))
          end,
          *if node.entities.length > 0
            indent(node.entities.map{|x| format(x)}.join("\n"))
          end,
          *if node.subtype_constraints.length > 0
            indent(node.subtype_constraints.map{|x| format(x)}.join("\n"))
          end,
          *if node.functions.length > 0
            indent(node.functions.map{|x| format(x)}.join("\n"))
          end,
          *if node.procedures.length > 0
            indent(node.procedures.map{|x| format(x)}.join("\n"))
          end,
          *if node.constants.length > 0
            indent([
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.variables.length > 0
            indent([
              'LOCAL',
              indent(node.variables.map{|x| format(x)}.join("\n")),
              [
                'END_LOCAL',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          [
            'END_FUNCTION',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_interface(node)
        [
          case node.kind
            when Model::Interface::USE then 'USE'
            when Model::Interface::REFERENCE then 'REFERENCE'
          end,
          ' ',
          'FROM',
          ' ',
          format(node.schema),
          *if node.items.length > 0
            item_indent = INDENT_CHAR * '('.length
            [
              "\n",
              indent([
                '(',
                node.items.map{|x| format(x)}.join(",\n#{item_indent}"),
                ')'
              ].join(''))
            ].join('')
          end,
          ';',
        ].join('')
      end

      def format_interface_item(node)
        [
          format(node.ref),
          *if node.id
            [
              ' ',
              'AS',
              ' ',
              node.id
            ]
          end
        ].join('')
      end

      def format_parameter(node)
        [
          *if node.var
            [
              'VAR',
              ' '
            ].join('')
          end,
          node.id,
          ' ',
          ':',
          ' ',
          format(node.type)
        ].join('')
      end

      def format_procedure(node)
        [
          [
            'PROCEDURE',
            ' ',
            node.id,
            *if node.parameters.length > 0
              parameter_indent = INDENT_CHAR * "PROCEDURE #{node.id}(".length
              [
                '(',
                node.parameters.map{|x| format(x)}.join(";\n#{parameter_indent}"),
                ')'
              ].join('')
            end,
            ';'
          ].join(''),
          *if node.types.length > 0
            indent(node.types.map{|x| format(x)}.join("\n"))
          end,
          *if node.entities.length > 0
            indent(node.entities.map{|x| format(x)}.join("\n"))
          end,
          *if node.subtype_constraints.length > 0
            indent(node.subtype_constraints.map{|x| format(x)}.join("\n"))
          end,
          *if node.functions.length > 0
            indent(node.functions.map{|x| format(x)}.join("\n"))
          end,
          *if node.procedures.length > 0
            indent(node.procedures.map{|x| format(x)}.join("\n"))
          end,
          *if node.constants.length > 0
            indent([
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.variables.length > 0
            indent([
              'LOCAL',
              indent(node.variables.map{|x| format(x)}.join("\n")),
              [
                'END_LOCAL',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          [
            'END_PROCEDURE',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_repository(node)
        node.schemas.map{|node| format(node)}.join("\n\n")
      end

      def format_rule(node)
        [
          [
            'RULE',
            ' ',
            node.id,
            ' ',
            'FOR',
            ' ',
            '(',
            node.applies_to.map{|x| format(x)}.join(', '),
            ')',
            ';'
          ].join(''),
          *if node.types.length > 0
            indent(node.types.map{|x| format(x)}.join("\n"))
          end,
          *if node.entities.length > 0
            indent(node.entities.map{|x| format(x)}.join("\n"))
          end,
          *if node.subtype_constraints.length > 0
            indent(node.subtype_constraints.map{|x| format(x)}.join("\n"))
          end,
          *if node.functions.length > 0
            indent(node.functions.map{|x| format(x)}.join("\n"))
          end,
          *if node.procedures.length > 0
            indent(node.procedures.map{|x| format(x)}.join("\n"))
          end,
          *if node.constants.length > 0
            indent([
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.variables.length > 0
            indent([
              'LOCAL',
              indent(node.variables.map{|x| format(x)}.join("\n")),
              [
                'END_LOCAL',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          *if node.where.length > 0
            [
              'WHERE',
              indent(node.where.map{|x| format(x)}.join("\n"))
            ]
          end,
          [
            'END_RULE',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_schema_head(node)
        [
          [
            'SCHEMA',
            ' ',
            node.id,
            *if node.version
              [
                ' ',
                format(node.version),
              ].join('')
            end,
            ';'
          ].join(''),
          *if node.interfaces.length > 0
            [
              '',
              node.interfaces.map{|x| format(x)}.join("\n")
            ]
          end
        ].join("\n")
      end

      def format_schema(node)
        schema_declarations = [
          *if node.constants.length > 0
            [
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n")
          end,
          *if node.types.length > 0
            node.types.map{|x| format(x)}
          end,
          *if node.entities.length > 0
            node.entities.map{|x| format(x)}
          end,
          *if node.subtype_constraints.length > 0
            node.subtype_constraints.map{|x| format(x)}
          end,
          *if node.functions.length > 0
            node.functions.map{|x| format(x)}
          end,
          *if node.rules.length > 0
            node.rules.map{|x| format(x)}
          end,
          *if node.procedures and node.procedures.length > 0
            node.procedures.map{|x| format(x)}
          end
        ]

        [
          format_schema_head(node),
          *if schema_declarations.length > 0
            [
              '',
              schema_declarations.join("\n\n"),
              ''
            ]
          end,
          [
            'END_SCHEMA',
            ';'
          ].join(''),
          *format_scope_remarks(node)
        ].join("\n")
      end

      def format_subtype_constraint(node)
        [
          [
            'SUBTYPE_CONSTRAINT',
            ' ',
            node.id,
            ' ',
            'FOR',
            ' ',
            format(node.applies_to),
            ';'
          ].join(''),
          *if node.abstract
            indent([
              'ABSTRACT',
              ' ',
              'SUPERTYPE',
              ';'
            ].join(''))
          end,
          *if node.total_over.length > 0
            indent([
              'TOTAL_OVER',
              '(',
              node.total_over.map{|x| format(x)}.join(', '),
              ')',
              ';'
            ].join(''))
          end,
          *if node.supertype_expression
            indent([
              format(node.supertype_expression),
              ';'
            ].join(''))
          end,
          [
            'END_SUBTYPE_CONSTRAINT',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_type(node)
        [
          [
            'TYPE',
            ' ',
            node.id,
            ' ',
            '=',
            ' ',
            format(node.type),
            ';',
          ].join(''),
          *if node.where.length > 0
            [
              'WHERE',
              indent(node.where.map{|x| format(x)}.join("\n"))
            ]
          end,
          [
            'END_TYPE',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_unique(node)
        [
          *if node.id
            [
              node.id,
              ':',
              ' '
            ].join('')
          end,
          node.attributes.map{|x| format(x)}.join(', '),
          ';'
        ].join('')
      end

      def format_variable(node)
        [
          node.id,
          ' ',
          ':',
          ' ',
          format(node.type),
          *if node.expression
            [
              ' ',
              ':=',
              ' ',
              format(node.expression),
            ].join('')
          end,
          ';'
        ].join('')
      end

      def format_where(node)
        [
          *if node.id
            [
              node.id,
              ':',
              ' '
            ].join('')
          end,
          format(node.expression),
          ';'
        ].join('')
      end

      def format_expressions_aggregate_initializer(node)
        [
          '[',
          node.items.map{|x| format(x)}.join(', '),
          ']'
        ].join('')
      end

      def format_expressions_aggregate_item(node)
        [
          format(node.expression),
          ':',
          format(node.repetition)
        ].join('')
      end

      def format_expressions_attribute_reference(node)
        [
          format(node.ref),
          '.',
          format(node.attribute)
        ].join('')
      end

      def format_expressions_binary_expression(node)
        [
          *if node.operand1.is_a? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand1.operator] > OPERATOR_PRECEDENCE[node.operator]
            '('
          end,
          format(node.operand1),
          *if node.operand1.is_a? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand1.operator] > OPERATOR_PRECEDENCE[node.operator]
            ')'
          end,
          ' ',
          case node.operator
            when Model::Expressions::BinaryExpression::ADDITION then '+'
            when Model::Expressions::BinaryExpression::AND then 'AND'
            when Model::Expressions::BinaryExpression::ANDOR then 'ANDOR'
            when Model::Expressions::BinaryExpression::COMBINE then '||'
            when Model::Expressions::BinaryExpression::EQUAL then '='
            when Model::Expressions::BinaryExpression::EXPONENTIATION then '**'
            when Model::Expressions::BinaryExpression::GREATER_THAN then '>'
            when Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL then '>='
            when Model::Expressions::BinaryExpression::IN then 'IN'
            when Model::Expressions::BinaryExpression::INSTANCE_EQUAL then ':=:'
            when Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL then ':<>:'
            when Model::Expressions::BinaryExpression::INTEGER_DIVISION then 'DIV'
            when Model::Expressions::BinaryExpression::LESS_THAN then '<'
            when Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL then '<='
            when Model::Expressions::BinaryExpression::LIKE then 'LIKE'
            when Model::Expressions::BinaryExpression::MODULO then 'MOD'
            when Model::Expressions::BinaryExpression::MULTIPLICATION then '*'
            when Model::Expressions::BinaryExpression::NOT_EQUAL then '<>'
            when Model::Expressions::BinaryExpression::OR then 'OR'
            when Model::Expressions::BinaryExpression::REAL_DIVISION then '/'
            when Model::Expressions::BinaryExpression::SUBTRACTION then '-'
            when Model::Expressions::BinaryExpression::XOR then 'XOR'
          end,
          ' ',
          *if node.operand2.is_a? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand2.operator] > OPERATOR_PRECEDENCE[node.operator]
            '('
          end,
          format(node.operand2),
          *if node.operand2.is_a? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand2.operator] > OPERATOR_PRECEDENCE[node.operator]
            ')'
          end,
        ].join('')
      end

      def format_expressions_call(node)
        [
          format(node.ref),
          '(',
          node.parameters.map{|x| format(x)}.join(', '),
          ')'
        ].join('')
      end

      def format_expressions_entity_constructor(node)
        [
          format(node.entity),
          '(',
          node.parameters.map{|x| format(x)}.join(', '),
          ')'
        ].join('')
      end

      def format_expressions_group_reference(node)
        [
          format(node.ref),
          '\\',
          format(node.entity)
        ].join('')
      end

      def format_expressions_index_reference(node)
        [
          format(node.ref),
          '[',
          format(node.index1),
          *if node.index2
            [
              ':',
              format(node.index2)
            ].join('')
          end,
          ']'
        ].join('')
      end

      def format_expressions_interval(node)
        [
          '{',
          format(node.low),
          ' ',
          case node.operator1
            when Model::Expressions::BinaryExpression::LESS_THAN then '<'
            when Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL then '<='
          end,
          ' ',
          format(node.item),
          ' ',
          case node.operator2
            when Model::Expressions::BinaryExpression::LESS_THAN then '<'
            when Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL then '<='
          end,
          ' ',
          format(node.high),
          '}'
        ].join('')
      end

      def format_expressions_query_expression(node)
        [
          'QUERY',
          '(',
          node.id,
          ' ',
          '<*',
          ' ',
          format(node.aggregate_source),
          ' ',
          '|',
          ' ',
          format(node.expression),
          *format_remarks(node).instance_eval{|x| x.length > 0 ? ["\n", *x, "\n"] : x},
          ')'
        ].join('')
      end

      def format_expressions_simple_reference(node)
        node.id
      end

      def format_expressions_unary_expression(node)
        [
          case node.operator
            when Model::Expressions::UnaryExpression::MINUS then '-'
            when Model::Expressions::UnaryExpression::NOT then 'NOT'
            when Model::Expressions::UnaryExpression::PLUS then '+'
          end,
          if node.operator == Model::Expressions::UnaryExpression::NOT
            ' '
          end,
          *if node.operand.is_a? Model::Expressions::BinaryExpression
            '('
          end,
          format(node.operand),
          *if node.operand.is_a? Model::Expressions::BinaryExpression
            ')'
          end
        ].join('')
      end

      def format_literals_binary(node)
        [
          '%',
          node.value
        ].join('')
      end

      def format_literals_integer(node)
        node.value
      end

      def format_literals_logical(node)
        case node.value
          when Model::Literals::Logical::TRUE then 'TRUE'
          when Model::Literals::Logical::FALSE then 'FALSE'
          when Model::Literals::Logical::UNKNOWN then 'UNKNOWN'
        end
      end

      def format_literals_real(node)
        node.value
      end

      def format_literals_string(node)
        if node.encoded
          [
            "\"",
            node.value,
            "\""
          ].join('')
        else
          [
            "'",
            node.value,
            "'"
          ].join('')
        end
      end

      def format_statements_alias(node)
        [
          [
            'ALIAS',
            ' ',
            node.id,
            ' ',
            'FOR',
            ' ',
            format(node.expression),
            ';'
          ].join(''),
          *if node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          *format_remarks(node),
          [
            'END_ALIAS',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_statements_assignment(node)
        [
          format(node.ref),
          ' ',
          ':=',
          ' ',
          format(node.expression),
          ';'
        ].join('')
      end

      def format_statements_call(node)
        [
          format(node.ref),
          *if node.parameters.length > 0
            [
              '(',
              node.parameters.map{|x| format(x)}.join(', '),
              ')'
            ].join('')
          end,
          ';'
        ].join('')
      end

      def format_statements_case(node)
        [
          [
            'CASE',
            ' ',
            format(node.expression),
            ' ',
            'OF'
          ].join(''),
          *if node.actions.length > 0
            node.actions.map{|x| format(x)}
          end,
          *if node.otherwise_statement
            [
              [
                'OTHERWISE',
                ' ',
                ':'
              ].join(''),
              indent(format(node.otherwise_statement))
            ]
          end,
          [
            'END_CASE',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_statements_case_action(node)
        [
          [
            node.labels.map{|x| format(x)}.join(', '),
            ' ',
            ':'
          ].join(''),
          indent(format(node.statement))
        ].join("\n")
      end

      def format_statements_compound(node)
        [
          'BEGIN',
          *if node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          [
            'END',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_statements_escape(node)
        [
          'ESCAPE',
          ';'
        ].join('')
      end

      def format_statements_if(node)
        [
          [
            'IF',
            ' ',
            format(node.expression),
            ' ',
            'THEN'
          ].join(''),
          *if node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          *if node.else_statements.length > 0
            [
              'ELSE',
              indent(node.else_statements.map{|x| format(x)}.join("\n")),
            ].join("\n")
          end,
          [
            'END_IF',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_statements_null(node)
        ';'
      end

      def format_statements_repeat(node)
        [
          [
            'REPEAT',
            *if node.id
              [
                ' ',
                node.id,
                ' ',
                ':=',
                ' ',
                format(node.bound1),
                ' ',
                'TO',
                ' ',
                format(node.bound2),
                *if node.increment
                  [
                    ' ',
                    'BY',
                    ' ',
                    format(node.increment)
                  ].join('')
                end
              ].join('')
            end,
            *if node.while_expression
              [
                ' ',
                'WHILE',
                ' ',
                format(node.while_expression)
              ].join('')
            end,
            *if node.until_expression
              [
                ' ',
                'UNTIL',
                ' ',
                format(node.until_expression)
              ].join('')
            end,
            ';'
          ].join(''),
          *if node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          *format_remarks(node),
          [
            'END_REPEAT',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_statements_return(node)
        [
          'RETURN',
          *if node.expression
            [
              ' ',
              '(',
              format(node.expression),
              ')'
            ].join('')
          end,
          ';'
        ].join('')
      end

      def format_statements_skip(node)
        [
          'SKIP',
          ';'
        ].join('')
      end

      def format_types_aggregate(node)
        'AGGREGATE'
      end

      def format_types_array(node)
        [
          'ARRAY',
          *if node.bound1 and node.bound2
            [
              ' ',
              '[',
              format(node.bound1),
              ':',
              format(node.bound2),
              ']',
            ].join('')
          end,
          ' ',
          'OF',
          *if node.optional
            [
              ' ',
              'OPTIONAL'
            ].join('')
          end,
          *if node.unique
            [
              ' ',
              'UNIQUE'
            ].join('')
          end,
          ' ',
          format(node.base_type)
        ].join('')
      end

      def format_types_bag(node)
        [
          'BAG',
          *if node.bound1 and node.bound2
            [
              ' ',
              '[',
              format(node.bound1),
              ':',
              format(node.bound2),
              ']',
            ].join('')
          end,
          ' ',
          'OF',
          ' ',
          format(node.base_type)
        ].join('')
      end

      def format_types_binary(node)
        [
          'BINARY',
          *if node.width
            [
              ' ',
              '(',
              format(node.width),
              ')'
            ].join('')
          end,
          *if node.fixed
            [
              ' ',
              'FIXED'
            ].join('')
          end
        ].join('')
      end

      def format_types_boolean(node)
        'BOOLEAN'
      end

      def format_types_enumeration(node)
        [
          *if node.extensible
            [
              'EXTENSIBLE',
              ' '
            ].join('')
          end,
          'ENUMERATION',
          *if node.items.length > 0
            item_indent = INDENT_CHAR * '('.length
            [
              ' ',
              'OF',
              "\n",
              indent([
                '(',
                node.items.map{|x| format(x)}.join(",\n#{item_indent}"),
                ')'
              ].join(''))
            ].join('')
          end,
          *if node.extension_type
            [
              ' ',
              'BASED_ON',
              ' ',
              format(node.extension_type)
            ].join('')
          end,
          *if node.extension_items.length > 0
            item_indent = INDENT_CHAR * '('.length
            [
              ' ',
              'WITH',
              "\n",
              indent([
                '(',
                node.extension_items.map{|x| format(x)}.join(",\n#{item_indent}"),
                ')'
              ].join(''))
            ].join('')
          end
        ].join('')
      end

      def format_types_generic_entity(node)
        [
          'GENERIC_ENTITY',
          *if node.id
            [
              ':',
              node.id
            ]
          end
        ].join('')
      end

      def format_types_generic(node)
        [
          'GENERIC',
          *if node.id
            [
              ':',
              node.id
            ]
          end
        ].join('')
      end

      def format_types_integer(node)
        'INTEGER'
      end

      def format_types_list(node)
        [
          'LIST',
          *if node.bound1 and node.bound2
            [
              ' ',
              '[',
              format(node.bound1),
              ':',
              format(node.bound2),
              ']',
            ].join('')
          end,
          ' ',
          'OF',
          *if node.unique
            [
              ' ',
              'UNIQUE'
            ].join('')
          end,
          ' ',
          format(node.base_type)
        ].join('')
      end

      def format_types_logical(node)
        'LOGICAL'
      end

      def format_types_number(node)
        'NUMBER'
      end

      def format_types_real(node)
        [
          'REAL',
          *if node.precision
            [
              ' ',
              '(',
              format(node.precision),
              ')'
            ].join('')
          end
        ].join('')
      end

      def format_types_select(node)
        [
          *if node.extensible
            [
              'EXTENSIBLE',
              ' '
            ].join('')
          end,
          *if node.generic_entity
            [
              'GENERIC_ENTITY',
              ' '
            ].join('')
          end,
          'SELECT',
          *if node.items.length > 0
            item_indent = INDENT_CHAR * '('.length
            [
              "\n",
              indent([
                '(',
                node.items.map{|x| format(x)}.join(",\n#{item_indent}"),
                ')'
              ].join(''))
            ].join('')
          end,
          *if node.extension_type
            [
              ' ',
              'BASED_ON',
              ' ',
              format(node.extension_type)
            ].join('')
          end,
          *if node.extension_items.length > 0
            item_indent = INDENT_CHAR * '('.length
            [
              ' ',
              'WITH',
              "\n",
              indent([
                '(',
                node.extension_items.map{|x| format(x)}.join(",\n#{item_indent}"),
                ')'
              ].join(''))
            ].join('')
          end
        ].join('')
      end

      def format_types_set(node)
        [
          'SET',
          *if node.bound1 and node.bound2
            [
              ' ',
              '[',
              format(node.bound1),
              ':',
              format(node.bound2),
              ']',
            ].join('')
          end,
          ' ',
          'OF',
          ' ',
          format(node.base_type)
        ].join('')
      end

      def format_types_string(node)
        [
          'STRING',
          *if node.width
            [
              ' ',
              '(',
              format(node.width),
              ')'
            ].join('')
          end,
          *if node.fixed
            [
              ' ',
              'FIXED'
            ].join('')
          end
        ].join('')
      end

      def indent(str)
        str.split("\n").map{|x| "#{INDENT}#{x}"}.join("\n")
      end

      def format_remark(node, remark)
        if remark.include?("\n")
          [
            [
              '(*',
              '"',
              node.path,
              '"',
            ].join(''),
            remark,
            '*)'
          ].join("\n")
        else
          [
            '--',
            '"',
            node.path,
            '"',
            ' ',
            remark
          ].join('')
        end
      end

      def format_remarks(node)
        if node.class.method_defined? :remarks
          node.remarks.map do |remark|
            format_remark(node, remark)
          end
        else
          []
        end
      end

      def format_scope_remarks(node)
        [
          *format_remarks(node),
          *node.children.select{|x| !x.is_a? Model::EnumerationItem or node.is_a? Model::Type}.flat_map{|x| format_scope_remarks(x)}
        ]
      end
    end
  end
end