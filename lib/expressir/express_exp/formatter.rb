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
        if node.instance_of? Model::Attribute
          format_attribute(node)
        elsif node.instance_of? Model::Constant
          format_constant(node)
        elsif node.instance_of? Model::Entity
          format_entity(node)
        elsif node.instance_of? Model::EnumerationItem
          format_enumeration_item(node)
        elsif node.instance_of? Model::Function
          format_function(node)
        elsif node.instance_of? Model::Interface
          format_interface(node)
        elsif node.instance_of? Model::Parameter
          format_parameter(node)
        elsif node.instance_of? Model::Procedure
          format_procedure(node)
        elsif node.instance_of? Model::RenamedRef
          format_renamed_ref(node)
        elsif node.instance_of? Model::Repository
          format_repository(node)
        elsif node.instance_of? Model::Rule
          format_rule(node)
        elsif node.instance_of? Model::Schema
          format_schema(node)
        elsif node.instance_of? Model::SubtypeConstraint
          format_subtype_constraint(node)
        elsif node.instance_of? Model::Type
          format_type(node)
        elsif node.instance_of? Model::Unique
          format_unique(node)
        elsif node.instance_of? Model::Variable
          format_variable(node)
        elsif node.instance_of? Model::Where
          format_where(node)
        elsif node.instance_of? Model::Expressions::AggregateInitializer
          format_expressions_aggregate_initializer(node)
        elsif node.instance_of? Model::Expressions::AggregateItem
          format_expressions_aggregate_item(node)
        elsif node.instance_of? Model::Expressions::AttributeReference
          format_expressions_attribute_reference(node)
        elsif node.instance_of? Model::Expressions::BinaryExpression
          format_expressions_binary_expression(node)
        elsif node.instance_of? Model::Expressions::Call
          format_expressions_call(node)
        elsif node.instance_of? Model::Expressions::EntityConstructor
          format_expressions_entity_constructor(node)
        elsif node.instance_of? Model::Expressions::GroupReference
          format_expressions_group_reference(node)
        elsif node.instance_of? Model::Expressions::IndexReference
          format_expressions_index_reference(node)
        elsif node.instance_of? Model::Expressions::Interval
          format_expressions_interval(node)
        elsif node.instance_of? Model::Expressions::QueryExpression
          format_expressions_query_expression(node)
        elsif node.instance_of? Model::Expressions::SimpleReference
          format_expressions_simple_reference(node)
        elsif node.instance_of? Model::Expressions::UnaryExpression
          format_expressions_unary_expression(node)
        elsif node.instance_of? Model::Literals::Binary
          format_literals_binary(node)
        elsif node.instance_of? Model::Literals::Integer
          format_literals_integer(node)
        elsif node.instance_of? Model::Literals::Logical
          format_literals_logical(node)
        elsif node.instance_of? Model::Literals::Real
          format_literals_real(node)
        elsif node.instance_of? Model::Literals::String
          format_literals_string(node)
        elsif node.instance_of? Model::Statements::Alias
          format_statements_alias(node)
        elsif node.instance_of? Model::Statements::Assignment
          format_statements_assignment(node)
        elsif node.instance_of? Model::Statements::Call
          format_statements_call(node)
        elsif node.instance_of? Model::Statements::Case
          format_statements_case(node)
        elsif node.instance_of? Model::Statements::CaseAction
          format_statements_case_action(node)
        elsif node.instance_of? Model::Statements::Compound
          format_statements_compound(node)
        elsif node.instance_of? Model::Statements::Escape
          format_statements_escape(node)
        elsif node.instance_of? Model::Statements::If
          format_statements_if(node)
        elsif node.instance_of? Model::Statements::Null
          format_statements_null(node)
        elsif node.instance_of? Model::Statements::Repeat
          format_statements_repeat(node)
        elsif node.instance_of? Model::Statements::Return
          format_statements_return(node)
        elsif node.instance_of? Model::Statements::Skip
          format_statements_skip(node)
        elsif node.instance_of? Model::Types::Aggregate
          format_types_aggregate(node)
        elsif node.instance_of? Model::Types::Array
          format_types_array(node)
        elsif node.instance_of? Model::Types::Bag
          format_types_bag(node)
        elsif node.instance_of? Model::Types::Binary
          format_types_binary(node)
        elsif node.instance_of? Model::Types::Boolean
          format_types_boolean(node)
        elsif node.instance_of? Model::Types::Enumeration
          format_types_enumeration(node)
        elsif node.instance_of? Model::Types::GenericEntity
          format_types_generic_entity(node)
        elsif node.instance_of? Model::Types::Generic
          format_types_generic(node)
        elsif node.instance_of? Model::Types::Integer
          format_types_integer(node)
        elsif node.instance_of? Model::Types::List
          format_types_list(node)
        elsif node.instance_of? Model::Types::Logical
          format_types_logical(node)
        elsif node.instance_of? Model::Types::Number
          format_types_number(node)
        elsif node.instance_of? Model::Types::Real
          format_types_real(node)
        elsif node.instance_of? Model::Types::Select
          format_types_select(node)
        elsif node.instance_of? Model::Types::Set
          format_types_set(node)
        elsif node.instance_of? Model::Types::String
          format_types_string(node)
        else
          puts node.class
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
        [
          [
            'ENTITY',
            ' ',
            node.id,
            *if node.abstract and !node.supertype_expression
              [
                "\n",
                INDENT,
                'ABSTRACT',
                ' ',
                'SUPERTYPE'
              ].join('')
            end,
            *if node.abstract and node.supertype_expression
              [
                "\n",
                INDENT,
                'ABSTRACT',
                ' ',
                'SUPERTYPE',
                ' ',
                'OF',
                ' ',
                '(',
                format(node.supertype_expression),
                ')'
              ].join('')
            end,
            *if !node.abstract and node.supertype_expression
              [
                "\n",
                INDENT,
                'SUPERTYPE',
                ' ',
                'OF',
                ' ',
                '(',
                format(node.supertype_expression),
                ')'
              ].join('')
            end,
            *if node.subtype_of and node.subtype_of.length > 0
              [
                "\n",
                INDENT,
                'SUBTYPE',
                ' ',
                'OF',
                ' ',
                '(',
                node.subtype_of.map{|x| format(x)}.join(', '),
                ')'
              ].join('')
            end,
            ';'
          ].join(''),
          *if node.explicit_attributes and node.explicit_attributes.length > 0
            indent(node.explicit_attributes.map{|x| format(x)}.join("\n"))
          end,
          *if node.derived_attributes and node.derived_attributes.length > 0
            indent([
              'DERIVE',
              indent(node.derived_attributes.map{|x| format(x)}.join("\n")),
            ].join("\n"))
          end,
          *if node.inverse_attributes and node.inverse_attributes.length > 0
            indent([
              'INVERSE',
              indent(node.inverse_attributes.map{|x| format(x)}.join("\n")),
            ].join("\n"))
          end,
          *if node.unique and node.unique.length > 0
            indent([
              'UNIQUE',
              indent(node.unique.map{|x| format(x)}.join("\n"))
            ].join("\n"))
          end,
          *if node.where and node.where.length > 0
            indent([
              'WHERE',
              indent(node.where.map{|x| format(x)}.join("\n")),
            ].join("\n"))
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
            *if node.parameters and node.parameters.length > 0
              [
                '(',
                node.parameters.map{|x| format(x)}.join('; '),
                ')'
              ].join('')
            end,
            ' ',
            ':',
            ' ',
            format(node.return_type),
            ';'
          ].join(''),
          *if node.declarations and node.declarations.length > 0
            indent(node.declarations.map{|x| format(x)}.join("\n"))
          end,
          *if node.constants and node.constants.length > 0
            indent([
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.variables and node.variables.length > 0
            indent([
              'LOCAL',
              indent(node.variables.map{|x| format(x)}.join("\n")),
              [
                'END_LOCAL',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.statements and node.statements.length > 0
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
          *if node.items and node.items.length > 0
            [
              "\n",
              INDENT,
              '(',
              node.items.map{|x| format(x)}.join(', '),
              ')'
            ].join('')
          end,
          ';',
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
            *if node.parameters and node.parameters.length > 0
              [
                '(',
                node.parameters.map{|x| format(x)}.join('; '),
                ')'
              ].join('')
            end,
            ';'
          ].join(''),
          *if node.declarations and node.declarations.length > 0
            indent(node.declarations.map{|x| format(x)}.join("\n"))
          end,
          *if node.constants and node.constants.length > 0
            indent([
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.variables and node.variables.length > 0
            indent([
              'LOCAL',
              indent(node.variables.map{|x| format(x)}.join("\n")),
              [
                'END_LOCAL',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.statements and node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          [
            'END_PROCEDURE',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_renamed_ref(node)
        [
          format(node.ref),
          ' ',
          'AS',
          ' ',
          node.id
        ].join('')
      end

      def format_repository(node)
        [
          *if node.schemas and node.schemas.length > 0
            node.schemas.map{|node| format(node)}
          end,
          *format_scope_remarks(node)
        ].join("\n")
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
          *if node.declarations and node.declarations.length > 0
            indent(node.declarations.map{|x| format(x)}.join("\n"))
          end,
          *if node.constants and node.constants.length > 0
            indent([
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.variables and node.variables.length > 0
            indent([
              'LOCAL',
              indent(node.variables.map{|x| format(x)}.join("\n")),
              [
                'END_LOCAL',
                ';'
              ].join('')
            ].join("\n"))
          end,
          *if node.statements and node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          *if node.where and node.where.length > 0
            indent([
              'WHERE',
              indent(node.where.map{|x| format(x)}.join("\n"))
            ].join("\n"))
          end,
          [
            'END_RULE',
            ';'
          ].join('')
        ].join("\n")
      end

      def format_schema(node)
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
          *if node.interfaces and node.interfaces.length > 0
            node.interfaces.map{|x| format(x)}.join("\n")
          end,
          *if node.constants and node.constants.length > 0
            [
              'CONSTANT',
              indent(node.constants.map{|x| format(x)}.join("\n")),
              [
                'END_CONSTANT',
                ';'
              ].join('')
            ].join("\n")
          end,
          *if node.declarations and node.declarations.length > 0
            node.declarations.map{|x| format(x)}.join("\n\n")
          end,
          [
            'END_SCHEMA',
            ';'
          ].join('')
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
          *if node.total_over and node.total_over.length > 0
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
          *if node.where and node.where.length > 0
            indent([
              'WHERE',
              indent(node.where.map{|x| format(x)}.join("\n"))
            ].join("\n"))
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
              ' ',
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
              ' ',
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
          *if node.operand1.instance_of? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand1.operator] > OPERATOR_PRECEDENCE[node.operator]
            '('
          end,
          format(node.operand1),
          *if node.operand1.instance_of? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand1.operator] > OPERATOR_PRECEDENCE[node.operator]
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
          *if node.operand2.instance_of? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand2.operator] > OPERATOR_PRECEDENCE[node.operator]
            '('
          end,
          format(node.operand2),
          *if node.operand2.instance_of? Model::Expressions::BinaryExpression and OPERATOR_PRECEDENCE[node.operand2.operator] > OPERATOR_PRECEDENCE[node.operator]
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
          *if node.operand.instance_of? Model::Expressions::BinaryExpression
            '('
          end,
          format(node.operand),
          *if node.operand.instance_of? Model::Expressions::BinaryExpression
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
          *if node.statements and node.statements.length > 0
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
          *if node.parameters and node.parameters.length > 0
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
          *if node.actions and node.actions.length > 0
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
          *if node.statements and node.statements.length > 0
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
          *if node.statements and node.statements.length > 0
            indent(node.statements.map{|x| format(x)}.join("\n"))
          end,
          *if node.else_statements and node.else_statements.length > 0
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
          *if node.statements and node.statements.length > 0
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
          *if node.items and node.items.length > 0
            [
              ' ',
              'OF',
              ' ',
              '(',
              node.items.map{|x| format(x)}.join(', '),
              ')'
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
          *if node.extension_items
            [
              ' ',
              'WITH',
              ' ',
              '(',
              node.extension_items.map{|x| format(x)}.join(', '),
              ')'
            ].join('')
          end
        ].join('')
      end

      def format_types_generic_entity(node)
        'GENERIC_ENTITY'
      end

      def format_types_generic(node)
        'GENERIC'
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
          *if node.items and node.items.length > 0
            [
              ' ',
              '(',
              node.items.map{|x| format(x)}.join(', '),
              ')'
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
          *if node.extension_items
            [
              ' ',
              'WITH',
              ' ',
              '(',
              node.extension_items.map{|x| format(x)}.join(', '),
              ')'
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

      def format_remark_ref(node)
        [
          *if node.class.method_defined? :parent and node.parent.class.method_defined? :id and node.parent != node
            [
              format_remark_ref(node.parent),
              '.'
            ].join('')
          end,
          node.id,
        ].join('')
      end

      def format_remark(node, remark)
        if remark.include?("\n")
          [
            [
              '(*',
              '"',
              format_remark_ref(node),
              '"',
            ].join(''),
            remark,
            '*)'
          ].join("\n")
        else
          [
            '--',
            '"',
            format_remark_ref(node),
            '"',
            ' ',
            remark
          ].join('')
        end
      end

      def format_remarks(node)
        if node.class.method_defined? :remarks and node.remarks and node.remarks.length > 0
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
          *if node.class.method_defined? :children
            node.children.flat_map do |x|
              if x != node
                format_scope_remarks(x)
              end
            end
          end
        ]
      end
    end
  end
end