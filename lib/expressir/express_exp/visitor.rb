begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require_relative "#{$1}/express_parser"
rescue LoadError
  require_relative "express_parser"
end
require "expressir/model"

# reference type is not recognized
# see note in A.1.5 Interpreted identifiers
# > It is expected that identifiers matching these syntax rules are known to an implementation.
# > How the implementation obtains this information is of no concern to the definition of the language. One
# > method of gaining this information is multi-pass parsing: the first pass collects the identifiers from their
# > declarations, so that subsequent passes are then able to distinguish a veriable_ref from a function_ref,
# > for example.
#
# - xxxRef - merged to SimpleReference
# - entityConstructor, functionCall - merged to Call
# 
# difference between generalized and instantiable types is not recognized
# see note in 8.6.2 Parameter data types
# > A syntactic construct such as ARRAY[1:3] OF REAL satisfies two syntactic productions —
# > aggregation_type and general_aggregation_type. It is considered to be instantiable no matter which
# > production it is required to satisfy in the syntax.
#
# static shorthands are unwrapped
# - entity attributes, function/procedure parameters, local variables

module Expressir
  module ExpressExp
    class Visitor < ::ExpressParser::Visitor
      REMARK_CHANNEL = 2

      def initialize(tokens)
        @tokens = tokens
        @attached_remark_tokens = Set.new

        super()
      end

      def visit(ctx)
        result = super(ctx)
        attach_source(ctx, result)
        attach_parent(ctx, result)
        attach_remarks(ctx, result)
        result
      end

      def visit_if(ctx)
        visit(ctx) if ctx
      end
    
      def visit_if_map(ctx)
        ctx.map{|ctx2| visit(ctx2)} if ctx
      end
    
      def visit_if_map_flatten(ctx)
        ctx.map{|ctx2| visit(ctx2)}.flatten if ctx
      end

      def get_tokens(ctx)
        start_index, stop_index = if ctx.instance_of? ::ExpressParser::SyntaxContext
          [0, @tokens.size - 1]
        else
          [ctx.start.token_index, ctx.stop.token_index]
        end

        @tokens[start_index..stop_index]
      end

      def get_source(ctx)
        source_tokens = get_tokens(ctx)
        if source_tokens.last.text == '<EOF>'
          source_tokens.pop
        end

        source_tokens.map{|x| x.text}.join('').force_encoding('UTF-8')
      end

      def attach_source(ctx, node)
        if node.class.method_defined? :source
          node.source = get_source(ctx)
        end
      end

      def attach_parent(ctx, node)
        if node.class.method_defined? :children
          node.children.each do |child_node|
            if child_node.class.method_defined? :parent
              child_node.parent = node
            end
          end
        end
      end

      def find_remark_target(node, path)
        current_node = node
        target_node = nil

        if current_node.class.method_defined? :find_or_create
          target_node = current_node.find_or_create(path)
        end
        while !target_node and current_node.class.method_defined? :parent and current_node.parent.class.method_defined? :find_or_create
          current_node = current_node.parent
          target_node = current_node.find_or_create(path)
        end

        target_node
      end

      def attach_remarks(ctx, node)
        remark_tokens = get_tokens(ctx).select{|x| x.channel == REMARK_CHANNEL}

        # skip already attached remarks
        remark_tokens = remark_tokens.select{|x| !@attached_remark_tokens.include?(x)}

        # parse remarks, find remark targets
        tagged_remark_tokens = remark_tokens.map do |remark_token|
          _, remark_tag, remark_text = if remark_token.text.start_with?('--')
            remark_token.text.match(/^--"([^"]*)"(.*)$/).to_a
          else
            remark_token.text.match(/^\(\*"([^"]*)"(.*)\*\)$/m).to_a
          end

          if remark_tag
            remark_target = find_remark_target(node, remark_tag)
          end
          if remark_text
            remark_text = remark_text.strip.force_encoding('UTF-8')
          end

          [remark_token, remark_target, remark_text]
        end.select{|x| x[1]}

        tagged_remark_tokens.each do |remark_token, remark_target, remark_text|
          # attach remark
          remark_target.remarks ||= []
          remark_target.remarks << remark_text

          # mark remark as attached, so that it is not attached again at higher nesting level
          @attached_remark_tokens << remark_token
        end
      end

      def visit_attribute_ref(ctx)
        ctx__attribute_id = ctx.attribute_id

        id = visit_if(ctx__attribute_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_constant_ref(ctx)
        ctx__constant_id = ctx.constant_id

        id = visit_if(ctx__constant_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_entity_ref(ctx)
        ctx__entity_id = ctx.entity_id

        id = visit_if(ctx__entity_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_enumeration_ref(ctx)
        ctx__enumeration_id = ctx.enumeration_id

        id = visit_if(ctx__enumeration_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_function_ref(ctx)
        ctx__function_id = ctx.function_id

        id = visit_if(ctx__function_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_parameter_ref(ctx)
        ctx__parameter_id = ctx.parameter_id

        id = visit_if(ctx__parameter_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_procedure_ref(ctx)
        ctx__procedure_id = ctx.procedure_id

        id = visit_if(ctx__procedure_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_rule_label_ref(ctx)
        ctx__rule_label_id = ctx.rule_label_id

        id = visit_if(ctx__rule_label_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_rule_ref(ctx)
        ctx__rule_id = ctx.rule_id

        id = visit_if(ctx__rule_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_schema_ref(ctx)
        ctx__schema_id = ctx.schema_id

        id = visit_if(ctx__schema_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_subtype_constraint_ref(ctx)
        ctx__subtype_constraint_id = ctx.subtype_constraint_id

        id = visit_if(ctx__subtype_constraint_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_type_label_ref(ctx)
        ctx__type_label_id = ctx.type_label_id

        id = visit_if(ctx__type_label_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_type_ref(ctx)
        ctx__type_id = ctx.type_id

        id = visit_if(ctx__type_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_variable_ref(ctx)
        ctx__variable_id = ctx.variable_id

        id = visit_if(ctx__variable_id)

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_abstract_entity_declaration(ctx)
        raise 'Invalid state'
      end

      def visit_abstract_supertype(ctx)
        raise 'Invalid state'
      end

      def visit_abstract_supertype_declaration(ctx)
        ctx__subtype_constraint = ctx.subtype_constraint

        visit_if(ctx__subtype_constraint)
      end

      def visit_actual_parameter_list(ctx)
        ctx__parameter = ctx.parameter

        visit_if_map(ctx__parameter)
      end

      def visit_add_like_op(ctx)
        ctx__text = ctx.text
        ctx__ADDITION = ctx__text == '+'
        ctx__SUBTRACTION = ctx__text == '-'
        ctx__OR = ctx.OR
        ctx__XOR = ctx.XOR

        if ctx__ADDITION
          Model::Expressions::BinaryExpression::ADDITION
        elsif ctx__SUBTRACTION
          Model::Expressions::BinaryExpression::SUBTRACTION
        elsif ctx__OR
          Model::Expressions::BinaryExpression::OR
        elsif ctx__XOR
          Model::Expressions::BinaryExpression::XOR
        else
          raise 'Invalid state'
        end
      end

      def visit_aggregate_initializer(ctx)
        ctx__element = ctx.element

        items = visit_if_map(ctx__element)

        Model::Expressions::AggregateInitializer.new({
          items: items
        })
      end

      def visit_aggregate_source(ctx)
        ctx__simple_expression = ctx.simple_expression

        visit_if(ctx__simple_expression)
      end

      def visit_aggregate_type(ctx)
        ctx__type_label = ctx.type_label
        ctx__parameter_type = ctx.parameter_type

        id = visit_if(ctx__type_label)
        base_type = visit_if(ctx__parameter_type)

        Model::Types::Aggregate.new({
          id: id,
          base_type: base_type
        })
      end

      def visit_aggregation_types(ctx)
        ctx__array_type = ctx.array_type
        ctx__bag_type = ctx.bag_type
        ctx__list_type = ctx.list_type
        ctx__set_type = ctx.set_type

        visit_if(ctx__array_type || ctx__bag_type || ctx__list_type || ctx__set_type)
      end

      def visit_algorithm_head(ctx)
        raise 'Invalid state'
      end

      def visit_alias_stmt(ctx)
        ctx__variable_id = ctx.variable_id
        ctx__general_ref = ctx.general_ref
        ctx__qualifier = ctx.qualifier
        ctx__stmt = ctx.stmt

        id = visit_if(ctx__variable_id)
        expression = handle_qualified_ref(visit_if(ctx__general_ref), ctx__qualifier)
        statements = visit_if_map(ctx__stmt)

        Model::Statements::Alias.new({
          id: id,
          expression: expression,
          statements: statements
        })
      end

      def visit_array_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__OPTIONAL = ctx.OPTIONAL
        ctx__UNIQUE = ctx.UNIQUE
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        optional = !!ctx__OPTIONAL
        unique = !!ctx__UNIQUE
        base_type = visit_if(ctx__instantiable_type)
        
        Model::Types::Array.new({
          bound1: bound1,
          bound2: bound2,
          optional: optional,
          unique: unique,
          base_type: base_type
        })
      end

      def visit_assignment_stmt(ctx)
        ctx__general_ref = ctx.general_ref
        ctx__qualifier = ctx.qualifier
        ctx__expression = ctx.expression

        ref = handle_qualified_ref(visit_if(ctx__general_ref), ctx__qualifier)
        expression = visit_if(ctx__expression)

        Model::Statements::Assignment.new({
          ref: ref,
          expression: expression
        })
      end

      def visit_attribute_decl(ctx)
        ctx__attribute_id = ctx.attribute_id
        ctx__redeclared_attribute = ctx.redeclared_attribute
        ctx__redeclared_attribute__qualified_attribute = ctx__redeclared_attribute&.qualified_attribute
        ctx__redeclared_attribute__attribute_id = ctx__redeclared_attribute&.attribute_id

        id = visit_if(ctx__attribute_id || ctx__redeclared_attribute__attribute_id)
        supertype_attribute = visit_if(ctx__redeclared_attribute__qualified_attribute)

        Model::Attribute.new({
          id: id,
          supertype_attribute: supertype_attribute
        })
      end

      def visit_attribute_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_attribute_qualifier(ctx)
        ctx__attribute_ref = ctx.attribute_ref

        attribute = visit_if(ctx__attribute_ref)

        Model::Expressions::AttributeReference.new({
          attribute: attribute
        })
      end

      def visit_attribute_reference(ctx)
        raise 'Invalid state'
      end

      def visit_bag_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__instantiable_type)
        
        Model::Types::Bag.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visit_binary_type(ctx)
        ctx__width_spec = ctx.width_spec
        ctx__width_spec__width = ctx__width_spec&.width
        ctx__width_spec__FIXED = ctx__width_spec&.FIXED

        width = visit_if(ctx__width_spec__width)
        fixed = !!ctx__width_spec__FIXED

        Model::Types::Binary.new({
          width: width,
          fixed: fixed
        })
      end

      def visit_boolean_type(ctx)
        Model::Types::Boolean.new
      end

      def visit_bound1(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_bound2(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_bound_spec(ctx)
        raise 'Invalid state'
      end

      def visit_built_in_constant(ctx)
        ctx__text = ctx.text

        id = ctx__text

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_built_in_function(ctx)
        ctx__text = ctx.text

        id = ctx__text

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_built_in_procedure(ctx)
        ctx__text = ctx.text

        id = ctx__text

        Model::Expressions::SimpleReference.new({
          id: id
        })
      end

      def visit_case_action(ctx)
        ctx__case_label = ctx.case_label
        ctx__stmt = ctx.stmt

        labels = visit_if_map(ctx__case_label)
        statement = visit_if(ctx__stmt)

        Model::Statements::CaseAction.new({
          labels: labels,
          statement: statement
        })
      end

      def visit_case_label(ctx)
        ctx__expression = ctx.expression

        visit_if(ctx__expression)
      end

      def visit_case_stmt(ctx)
        ctx__selector = ctx.selector
        ctx__case_action = ctx.case_action
        ctx__stmt = ctx.stmt
        ctx__selector__expression = ctx__selector&.expression

        expression = visit_if(ctx__selector__expression)
        actions = visit_if_map_flatten(ctx__case_action)
        otherwise_statement = visit_if(ctx__stmt)

        Model::Statements::Case.new({
          expression: expression,
          actions: actions,
          otherwise_statement: otherwise_statement
        })
      end

      def visit_compound_stmt(ctx)
        ctx__stmt = ctx.stmt

        statements = visit_if_map(ctx__stmt)

        Model::Statements::Compound.new({
          statements: statements
        })
      end

      def visit_concrete_types(ctx)
        ctx__aggregation_types = ctx.aggregation_types
        ctx__simple_types = ctx.simple_types
        ctx__type_ref = ctx.type_ref

        visit_if(ctx__aggregation_types || ctx__simple_types || ctx__type_ref)
      end

      def visit_constant_body(ctx)
        ctx__constant_id = ctx.constant_id
        ctx__instantiable_type = ctx.instantiable_type
        ctx__expression = ctx.expression

        id = visit_if(ctx__constant_id)
        type = visit_if(ctx__instantiable_type)
        expression = visit_if(ctx__expression)

        Model::Constant.new({
          id: id,
          type: type,
          expression: expression
        })
      end

      def visit_constant_decl(ctx)
        ctx__constant_body = ctx.constant_body

        visit_if_map(ctx__constant_body)
      end

      def visit_constant_factor(ctx)
        ctx__built_in_constant = ctx.built_in_constant
        ctx__constant_ref = ctx.constant_ref

        visit_if(ctx__built_in_constant || ctx__constant_ref)
      end

      def visit_constant_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_constructed_types(ctx)
        ctx__enumeration_type = ctx.enumeration_type
        ctx__select_type = ctx.select_type

        visit_if(ctx__enumeration_type || ctx__select_type)
      end

      def visit_declaration(ctx)
        ctx__entity_decl = ctx.entity_decl
        ctx__function_decl = ctx.function_decl
        ctx__procedure_decl = ctx.procedure_decl
        ctx__subtype_constraint_decl = ctx.subtype_constraint_decl
        ctx__type_decl = ctx.type_decl

        visit_if(ctx__entity_decl || ctx__function_decl || ctx__procedure_decl || ctx__subtype_constraint_decl || ctx__type_decl)
      end

      def visit_derived_attr(ctx)
        ctx__attribute_decl = ctx.attribute_decl
        ctx__parameter_type = ctx.parameter_type
        ctx__expression = ctx.expression

        attribute = visit_if(ctx__attribute_decl)
        type = visit_if(ctx__parameter_type)
        expression = visit_if(ctx__expression)

        Model::Attribute.new({
          id: attribute.id,
          kind: Model::Attribute::DERIVED,
          supertype_attribute: attribute.supertype_attribute,
          type: type,
          expression: expression
        })
      end

      def visit_derive_clause(ctx)
        ctx__derived_attr = ctx.derived_attr

        visit_if_map(ctx__derived_attr)
      end

      def visit_domain_rule(ctx)
        ctx__rule_label_id = ctx.rule_label_id
        ctx__expression = ctx.expression

        id = visit_if(ctx__rule_label_id)
        expression = visit_if(ctx__expression)

        Model::Where.new({
          id: id,
          expression: expression
        })
      end

      def visit_element(ctx)
        ctx__expression = ctx.expression
        ctx__repetition = ctx.repetition

        if ctx__repetition
          expression = visit_if(ctx__expression)
          repetition = visit_if(ctx__repetition)

          Model::Expressions::AggregateItem.new({
            expression: expression,
            repetition: repetition
          })
        else
          visit_if(ctx__expression)
        end
      end

      def visit_entity_body(ctx)
        raise 'Invalid state'
      end

      def visit_entity_constructor(ctx)
        ctx__entity_ref = ctx.entity_ref
        ctx__expression = ctx.expression

        ref = visit_if(ctx__entity_ref)
        parameters = visit_if_map(ctx__expression)

        Model::Expressions::Call.new({
          ref: ref,
          parameters: parameters
        })
      end

      def visit_entity_decl(ctx)
        ctx__entity_head = ctx.entity_head
        ctx__entity_body = ctx.entity_body
        ctx__entity_head__entity_id = ctx__entity_head&.entity_id
        ctx__entity_head__subsuper = ctx__entity_head&.subsuper
        ctx__entity_head__subsuper__supertype_constraint = ctx__entity_head__subsuper&.supertype_constraint
        ctx__entity_head__subsuper__supertype_constraint__abstract_entity_declaration = ctx__entity_head__subsuper__supertype_constraint&.abstract_entity_declaration
        ctx__entity_head__subsuper__supertype_constraint__abstract_supertype_declaration = ctx__entity_head__subsuper__supertype_constraint&.abstract_supertype_declaration
        ctx__entity_head__subsuper__supertype_constraint__supertype_rule = ctx__entity_head__subsuper__supertype_constraint&.supertype_rule
        ctx__entity_head__subsuper__subtype_declaration = ctx__entity_head__subsuper&.subtype_declaration
        ctx__entity_body__explicit_attr = ctx__entity_body&.explicit_attr
        ctx__entity_body__derive_clause = ctx__entity_body&.derive_clause
        ctx__entity_body__inverse_clause = ctx__entity_body&.inverse_clause
        ctx__entity_body__unique_clause = ctx__entity_body&.unique_clause
        ctx__entity_body__where_clause = ctx__entity_body&.where_clause

        id = visit_if(ctx__entity_head__entity_id)
        abstract = !!(ctx__entity_head__subsuper__supertype_constraint__abstract_entity_declaration || ctx__entity_head__subsuper__supertype_constraint__abstract_supertype_declaration)
        supertype_expression = visit_if(ctx__entity_head__subsuper__supertype_constraint__abstract_supertype_declaration || ctx__entity_head__subsuper__supertype_constraint__supertype_rule)
        subtype_of = visit_if(ctx__entity_head__subsuper__subtype_declaration)
        attributes = [
          *visit_if_map_flatten(ctx__entity_body__explicit_attr),
          *visit_if(ctx__entity_body__derive_clause),
          *visit_if(ctx__entity_body__inverse_clause)
        ]
        unique = visit_if(ctx__entity_body__unique_clause)
        where = visit_if(ctx__entity_body__where_clause)

        Model::Entity.new({
          id: id,
          abstract: abstract,
          supertype_expression: supertype_expression,
          subtype_of: subtype_of,
          attributes: attributes,
          unique: unique,
          where: where
        })
      end

      def visit_entity_head(ctx)
        raise 'Invalid state'
      end

      def visit_entity_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_enumeration_extension(ctx)
        raise 'Invalid state'
      end

      def visit_enumeration_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_enumeration_items(ctx)
        ctx__enumeration_item = ctx.enumeration_item

        visit_if_map(ctx__enumeration_item)
      end

      def visit_enumeration_item(ctx)
        ctx__enumeration_id = ctx.enumeration_id

        id = visit_if(ctx__enumeration_id)

        Model::EnumerationItem.new({
          id: id
        })
      end

      def visit_enumeration_reference(ctx)
        ctx__type_ref = ctx.type_ref
        ctx__enumeration_ref = ctx.enumeration_ref

        if ctx__type_ref
          ref = visit_if(ctx__type_ref)
          attribute = visit_if(ctx__enumeration_ref)
  
          Model::Expressions::AttributeReference.new({
            ref: ref,
            attribute: attribute
          })
        else
          visit_if(ctx__enumeration_ref)
        end
      end

      def visit_enumeration_type(ctx)
        ctx__EXTENSIBLE = ctx.EXTENSIBLE
        ctx__enumeration_items = ctx.enumeration_items
        ctx__enumeration_extension = ctx.enumeration_extension
        ctx__enumeration_extension__type_ref = ctx__enumeration_extension&.type_ref
        ctx__enumeration_extension__enumeration_items = ctx__enumeration_extension&.enumeration_items

        extensible = !!ctx__EXTENSIBLE
        items = visit_if(ctx__enumeration_items)
        extension_type = visit_if(ctx__enumeration_extension__type_ref)
        extension_items = visit_if(ctx__enumeration_extension__enumeration_items)

        Model::Types::Enumeration.new({
          extensible: extensible,
          items: items,
          extension_type: extension_type,
          extension_items: extension_items
        })
      end

      def visit_escape_stmt(ctx)
        Model::Statements::Escape.new
      end

      def visit_explicit_attr(ctx)
        ctx__attribute_decl = ctx.attribute_decl
        ctx__OPTIONAL = ctx.OPTIONAL
        ctx__parameter_type = ctx.parameter_type

        attributes = visit_if_map(ctx__attribute_decl)
        optional = !!ctx__OPTIONAL
        type = visit_if(ctx__parameter_type)

        attributes.map do |attribute|
          Model::Attribute.new({
            id: attribute.id,
            kind: Model::Attribute::EXPLICIT,
            supertype_attribute: attribute.supertype_attribute,
            optional: optional,
            type: type
          })
        end
      end

      def visit_expression(ctx)
        ctx__simple_expression = ctx.simple_expression
        ctx__rel_op_extended = ctx.rel_op_extended

        if ctx__simple_expression.length == 2
          operator = visit_if(ctx__rel_op_extended)
          operand1 = visit_if(ctx__simple_expression[0])
          operand2 = visit_if(ctx__simple_expression[1])

          Model::Expressions::BinaryExpression.new({
            operator: operator,
            operand1: operand1,
            operand2: operand2
          })
        else
          visit_if(ctx__simple_expression[0])
        end
      end

      def visit_factor(ctx)
        ctx__simple_factor = ctx.simple_factor

        if ctx__simple_factor.length == 2
          operator = Model::Expressions::BinaryExpression::EXPONENTIATION
          operand1 = visit(ctx__simple_factor[0])
          operand2 = visit(ctx__simple_factor[1])

          Model::Expressions::BinaryExpression.new({
            operator: operator,
            operand1: operand1,
            operand2: operand2
          })
        elsif ctx__simple_factor.length == 1
          visit_if(ctx__simple_factor[0])
        else
          raise 'Invalid state'
        end
      end

      def visit_formal_parameter(ctx)
        ctx__parameter_id = ctx.parameter_id
        ctx__parameter_type = ctx.parameter_type

        ids = visit_if_map(ctx__parameter_id)
        type = visit_if(ctx__parameter_type)

        ids.map do |id|
          Model::Parameter.new({
            id: id,
            type: type
          })
        end
      end

      def visit_function_call(ctx)
        ctx__built_in_function = ctx.built_in_function
        ctx__function_ref = ctx.function_ref
        ctx__actual_parameter_list = ctx.actual_parameter_list

        ref = visit_if(ctx__built_in_function || ctx__function_ref)
        parameters = visit_if(ctx__actual_parameter_list)

        Model::Expressions::Call.new({
          ref: ref,
          parameters: parameters
        })
      end

      def visit_function_decl(ctx)
        ctx__function_head = ctx.function_head
        ctx__algorithm_head = ctx.algorithm_head
        ctx__stmt = ctx.stmt
        ctx__function_head__function_id = ctx__function_head&.function_id
        ctx__function_head__formal_parameter = ctx__function_head&.formal_parameter
        ctx__function_head__parameter_type = ctx__function_head&.parameter_type
        ctx__algorithm_head__declaration = ctx__algorithm_head&.declaration
        ctx__algorithm_head__constant_decl = ctx__algorithm_head&.constant_decl
        ctx__algorithm_head__local_decl = ctx__algorithm_head&.local_decl

        id = visit_if(ctx__function_head__function_id)
        parameters = visit_if_map_flatten(ctx__function_head__formal_parameter)
        return_type = visit_if(ctx__function_head__parameter_type)
        declarations = visit_if_map(ctx__algorithm_head__declaration)
        constants = visit_if(ctx__algorithm_head__constant_decl)
        variables = visit_if(ctx__algorithm_head__local_decl)
        statements = visit_if_map(ctx__stmt)

        Model::Function.new({
          id: id,
          parameters: parameters,
          return_type: return_type,
          declarations: declarations,
          constants: constants,
          variables: variables,
          statements: statements
        })
      end

      def visit_function_head(ctx)
        raise 'Invalid state'
      end

      def visit_function_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_generalized_types(ctx)
        ctx__aggregate_type = ctx.aggregate_type
        ctx__general_aggregation_types = ctx.general_aggregation_types
        ctx__generic_entity_type = ctx.generic_entity_type
        ctx__generic_type = ctx.generic_type

        visit_if(ctx__aggregate_type || ctx__general_aggregation_types || ctx__generic_entity_type || ctx__generic_type)
      end

      def visit_general_aggregation_types(ctx)
        ctx__general_array_type = ctx.general_array_type
        ctx__general_bag_type = ctx.general_bag_type
        ctx__general_list_type = ctx.general_list_type
        ctx__general_set_type = ctx.general_set_type

        visit_if(ctx__general_array_type || ctx__general_bag_type || ctx__general_list_type || ctx__general_set_type)
      end

      def visit_general_array_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__OPTIONAL = ctx.OPTIONAL
        ctx__UNIQUE = ctx.UNIQUE
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        optional = !!ctx__OPTIONAL
        unique = !!ctx__UNIQUE
        base_type = visit_if(ctx__parameter_type)
        
        Model::Types::Array.new({
          bound1: bound1,
          bound2: bound2,
          optional: optional,
          unique: unique,
          base_type: base_type
        })
      end

      def visit_general_bag_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__parameter_type)
        
        Model::Types::Bag.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visit_general_list_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__UNIQUE = ctx.UNIQUE
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        unique = !!ctx__UNIQUE
        base_type = visit_if(ctx__parameter_type)
        
        Model::Types::List.new({
          bound1: bound1,
          bound2: bound2,
          unique: unique,
          base_type: base_type
        })
      end

      def visit_general_ref(ctx)
        ctx__parameter_ref = ctx.parameter_ref
        ctx__variable_id = ctx.variable_id

        visit_if(ctx__parameter_ref || ctx__variable_id)
      end

      def visit_general_set_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__parameter_type)
        
        Model::Types::Set.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visit_generic_entity_type(ctx)
        ctx__type_label = ctx.type_label

        id = visit_if(ctx__type_label)

        Model::Types::GenericEntity.new({
          id: id
        })
      end

      def visit_generic_type(ctx)
        ctx__type_label = ctx.type_label

        id = visit_if(ctx__type_label)

        Model::Types::Generic.new({
          id: id
        })
      end

      def visit_group_qualifier(ctx)
        ctx__entity_ref = ctx.entity_ref

        entity = visit_if(ctx__entity_ref)

        Model::Expressions::GroupReference.new({
          entity: entity
        })
      end

      def visit_group_reference(ctx)
        raise 'Invalid state'
      end

      def visit_if_stmt(ctx)
        ctx__logical_expression = ctx.logical_expression
        ctx__if_stmt_statements = ctx.if_stmt_statements
        ctx__if_stmt_else_statements = ctx.if_stmt_else_statements

        expression = visit_if(ctx__logical_expression)
        statements = visit_if(ctx__if_stmt_statements)
        else_statements = visit_if(ctx__if_stmt_else_statements)

        Model::Statements::If.new({
          expression: expression,
          statements: statements,
          else_statements: else_statements
        })
      end

      def visit_if_stmt_statements(ctx)
        ctx__stmt = ctx.stmt

        visit_if_map(ctx__stmt)
      end

      def visit_if_stmt_else_statements(ctx)
        ctx__stmt = ctx.stmt

        visit_if_map(ctx__stmt)
      end

      def visit_increment(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_increment_control(ctx)
        raise 'Invalid state'
      end

      def visit_index(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_index1(ctx)
        ctx__index = ctx.index

        visit_if(ctx__index)
      end

      def visit_index2(ctx)
        ctx__index = ctx.index

        visit_if(ctx__index)
      end

      def visit_index_qualifier(ctx)
        ctx__index1 = ctx.index1
        ctx__index2 = ctx.index2

        index1 = visit_if(ctx__index1)
        index2 = visit_if(ctx__index2)

        Model::Expressions::IndexReference.new({
          index1: index1,
          index2: index2
        })
      end

      def visit_index_reference(ctx)
        raise 'Invalid state'
      end

      def visit_instantiable_type(ctx)
        ctx__concrete_types = ctx.concrete_types
        ctx__entity_ref = ctx.entity_ref

        visit_if(ctx__concrete_types || ctx__entity_ref)
      end

      def visit_integer_type(ctx)
        Model::Types::Integer.new
      end

      def visit_interface_specification(ctx)
        ctx__reference_clause = ctx.reference_clause
        ctx__use_clause = ctx.use_clause

        visit_if(ctx__reference_clause || ctx__use_clause)
      end

      def visit_interval(ctx)
        ctx__interval_low = ctx.interval_low
        ctx__interval_op = ctx.interval_op
        ctx__interval_item = ctx.interval_item
        ctx__interval_high = ctx.interval_high

        low = visit_if(ctx__interval_low)
        operator1 = visit_if(ctx__interval_op[0])
        item = visit_if(ctx__interval_item)
        operator2 = visit_if(ctx__interval_op[1])
        high = visit_if(ctx__interval_high)

        Model::Expressions::Interval.new({
          low: low,
          operator1: operator1,
          item: item,
          operator2: operator2,
          high: high
        })
      end

      def visit_interval_high(ctx)
        ctx__simple_expression = ctx.simple_expression

        visit_if(ctx__simple_expression)
      end

      def visit_interval_item(ctx)
        ctx__simple_expression = ctx.simple_expression

        visit_if(ctx__simple_expression)
      end

      def visit_interval_low(ctx)
        ctx__simple_expression = ctx.simple_expression

        visit_if(ctx__simple_expression)
      end

      def visit_interval_op(ctx)
        ctx__text = ctx.text
        ctx__LESS_THAN = ctx__text == '<'
        ctx__LESS_THAN_OR_EQUAL = ctx__text == '<='

        if ctx__LESS_THAN
          Model::Expressions::BinaryExpression::LESS_THAN
        elsif ctx__LESS_THAN_OR_EQUAL
          Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL
        else
          raise 'Invalid state'
        end
      end

      def visit_inverse_attr(ctx)
        ctx__attribute_decl = ctx.attribute_decl
        ctx__inverse_attr_type = ctx.inverse_attr_type
        ctx__entity_ref = ctx.entity_ref
        ctx__attribute_ref = ctx.attribute_ref

        attribute = visit_if(ctx__attribute_decl)
        type = visit_if(ctx__inverse_attr_type)
        expression = if ctx__entity_ref
          ref = visit(ctx__entity_ref)
          attribute_ref = visit(ctx__attribute_ref)

          Model::Expressions::AttributeReference.new({
            ref: ref,
            attribute: attribute_ref
          })
        else
          visit(ctx__attribute_ref)
        end

        Model::Attribute.new({
          id: attribute.id,
          kind: Model::Attribute::INVERSE,
          supertype_attribute: attribute.supertype_attribute,
          type: type,
          expression: expression
        })
      end

      def visit_inverse_attr_type(ctx)
        ctx__SET = ctx.SET
        ctx__BAG = ctx.BAG
        ctx__bound_spec = ctx.bound_spec
        ctx__entity_ref = ctx.entity_ref
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        if ctx__SET
          bound1 = visit_if(ctx__bound_spec__bound1)
          bound2 = visit_if(ctx__bound_spec__bound2)
          base_type = visit_if(ctx__entity_ref)

          Model::Types::Set.new({
            bound1: bound1,
            bound2: bound2,
            base_type: base_type
          })
        elsif ctx__BAG
          bound1 = visit_if(ctx__bound_spec__bound1)
          bound2 = visit_if(ctx__bound_spec__bound2)
          base_type = visit_if(ctx__entity_ref)

          Model::Types::Bag.new({
            bound1: bound1,
            bound2: bound2,
            base_type: base_type
          })
        else
          visit_if(ctx__entity_ref)
        end
      end

      def visit_inverse_clause(ctx)
        ctx__inverse_attr = ctx.inverse_attr

        visit_if_map(ctx__inverse_attr)
      end

      def visit_list_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__UNIQUE = ctx.UNIQUE
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        unique = !!ctx__UNIQUE
        base_type = visit_if(ctx__instantiable_type)
        
        Model::Types::List.new({
          bound1: bound1,
          bound2: bound2,
          unique: unique,
          base_type: base_type
        })
      end

      def visit_literal(ctx)
        ctx__BinaryLiteral = ctx.BinaryLiteral
        ctx__IntegerLiteral = ctx.IntegerLiteral
        ctx__logical_literal = ctx.logical_literal
        ctx__RealLiteral = ctx.RealLiteral
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
          raise 'Invalid state'
        end
      end

      def visit_local_decl(ctx)
        ctx__local_variable = ctx.local_variable

        visit_if_map_flatten(ctx__local_variable)
      end

      def visit_local_variable(ctx)
        ctx__variable_id = ctx.variable_id
        ctx__parameter_type = ctx.parameter_type
        ctx__expression = ctx.expression

        ids = visit_if_map(ctx__variable_id)
        type = visit_if(ctx__parameter_type)
        expression = visit_if(ctx__expression)

        ids.map do |id|
          Model::Variable.new({
            id: id,
            type: type,
            expression: expression
          })
        end
      end

      def visit_logical_expression(ctx)
        ctx__expression = ctx.expression

        visit_if(ctx__expression)
      end

      def visit_logical_literal(ctx)
        ctx__TRUE = ctx.TRUE
        ctx__FALSE = ctx.FALSE
        ctx__UNKNOWN = ctx.UNKNOWN

        value = if ctx__TRUE
          Model::Literals::Logical::TRUE
        elsif ctx__FALSE
          Model::Literals::Logical::FALSE
        elsif ctx__UNKNOWN
          Model::Literals::Logical::UNKNOWN
        else
          raise 'Invalid state'
        end

        Model::Literals::Logical.new({
          value: value
        })
      end

      def visit_logical_type(ctx)
        Model::Types::Logical.new
      end

      def visit_multiplication_like_op(ctx)
        ctx__text = ctx.text
        ctx__MULTIPLICATION = ctx__text == '*'
        ctx__REAL_DIVISION = ctx__text == '/'
        ctx__INTEGER_DIVISION = ctx.DIV
        ctx__MODULO = ctx.MOD
        ctx__AND = ctx.AND
        ctx__COMBINE = ctx__text == '||'

        if ctx__MULTIPLICATION
          Model::Expressions::BinaryExpression::MULTIPLICATION
        elsif ctx__REAL_DIVISION
          Model::Expressions::BinaryExpression::REAL_DIVISION
        elsif ctx__INTEGER_DIVISION
          Model::Expressions::BinaryExpression::INTEGER_DIVISION
        elsif ctx__MODULO
          Model::Expressions::BinaryExpression::MODULO
        elsif ctx__AND
          Model::Expressions::BinaryExpression::AND
        elsif ctx__COMBINE
          Model::Expressions::BinaryExpression::COMBINE
        else
          raise 'Invalid state'
        end
      end

      def visit_named_types(ctx)
        ctx__entity_ref = ctx.entity_ref
        ctx__type_ref = ctx.type_ref

        visit_if(ctx__entity_ref || ctx__type_ref)
      end

      def visit_named_type_or_rename(ctx)
        ctx__named_types = ctx.named_types
        ctx__entity_id = ctx.entity_id
        ctx__type_id = ctx.type_id

        ref = visit_if(ctx__named_types)
        id = visit_if(ctx__entity_id || ctx__type_id)

        if id
          Model::RenamedRef.new({
            ref: ref,
            id: id
          })
        else
          ref
        end
      end

      def visit_null_stmt(ctx)
        Model::Statements::Null.new
      end

      def visit_number_type(ctx)
        Model::Types::Number.new
      end

      def visit_numeric_expression(ctx)
        ctx__simple_expression = ctx.simple_expression

        visit_if(ctx__simple_expression)
      end

      def visit_one_of(ctx)
        ctx__supertype_expression = ctx.supertype_expression

        ref = Model::Expressions::SimpleReference.new({ id: 'ONEOF' })
        parameters = visit_if_map(ctx__supertype_expression)

        Model::Expressions::Call.new({
          ref: ref,
          parameters: parameters
        })
      end

      def visit_parameter(ctx)
        ctx__expression = ctx.expression

        visit_if(ctx__expression)
      end

      def visit_parameter_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_parameter_type(ctx)
        ctx__generalized_types = ctx.generalized_types
        ctx__named_types = ctx.named_types
        ctx__simple_types = ctx.simple_types

        visit_if(ctx__generalized_types || ctx__named_types || ctx__simple_types)
      end

      def visit_population(ctx)
        ctx__entity_ref = ctx.entity_ref

        visit_if(ctx__entity_ref)
      end

      def visit_precision_spec(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_primary(ctx)
        ctx__literal = ctx.literal
        ctx__qualifiable_factor = ctx.qualifiable_factor
        ctx__qualifier = ctx.qualifier

        if ctx__literal
          visit(ctx__literal)
        elsif ctx__qualifiable_factor
          handle_qualified_ref(visit(ctx__qualifiable_factor), ctx__qualifier)
        else
          raise 'Invalid state'
        end
      end

      def visit_procedure_call_stmt(ctx)
        ctx__built_in_procedure = ctx.built_in_procedure
        ctx__procedure_ref = ctx.procedure_ref
        ctx__actual_parameter_list = ctx.actual_parameter_list

        ref = visit_if(ctx__built_in_procedure || ctx__procedure_ref)
        parameters = visit_if(ctx__actual_parameter_list)

        Model::Statements::Call.new({
          ref: ref,
          parameters: parameters
        })
      end

      def visit_procedure_decl(ctx)
        ctx__procedure_head = ctx.procedure_head
        ctx__algorithm_head = ctx.algorithm_head
        ctx__stmt = ctx.stmt
        ctx__procedure_head__procedure_id = ctx__procedure_head&.procedure_id
        ctx__procedure_head__procedure_head_parameter = ctx__procedure_head&.procedure_head_parameter
        ctx__algorithm_head__declaration = ctx__algorithm_head&.declaration
        ctx__algorithm_head__constant_decl = ctx__algorithm_head&.constant_decl
        ctx__algorithm_head__local_decl = ctx__algorithm_head&.local_decl

        id = visit_if(ctx__procedure_head__procedure_id)
        parameters = visit_if_map_flatten(ctx__procedure_head__procedure_head_parameter)
        declarations = visit_if_map(ctx__algorithm_head__declaration)
        constants = visit_if(ctx__algorithm_head__constant_decl)
        variables = visit_if(ctx__algorithm_head__local_decl)
        statements = visit_if_map(ctx__stmt)

        Model::Procedure.new({
          id: id,
          parameters: parameters,
          declarations: declarations,
          constants: constants,
          variables: variables,
          statements: statements
        })
      end

      def visit_procedure_head(ctx)
        raise 'Invalid state'
      end

      def visit_procedure_head_parameter(ctx)
        ctx__formal_parameter = ctx.formal_parameter
        ctx__VAR = ctx.VAR

        parameters = visit(ctx__formal_parameter)

        if ctx.VAR
          parameters.map do |parameter|
            Model::Parameter.new({
              id: parameter.id,
              var: true,
              type: parameter.type
            })
          end
        else
          parameters
        end
      end

      def visit_procedure_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_qualifiable_factor(ctx)
        ctx__attribute_ref = ctx.attribute_ref
        ctx__constant_factor = ctx.constant_factor
        ctx__function_call = ctx.function_call
        ctx__general_ref = ctx.general_ref
        ctx__population = ctx.population

        visit_if(ctx__attribute_ref || ctx__constant_factor || ctx__function_call || ctx__general_ref || ctx__population)
      end

      def visit_qualified_attribute(ctx)
        ctx__group_qualifier = ctx.group_qualifier
        ctx__attribute_qualifier = ctx.attribute_qualifier

        id = 'SELF'
        group_reference = visit_if(ctx__group_qualifier)
        attribute_reference = visit_if(ctx__attribute_qualifier)

        Model::Expressions::AttributeReference.new({
          ref: Model::Expressions::GroupReference.new({
            ref: Model::Expressions::SimpleReference.new({
              id: id
            }),
            entity: group_reference.entity
          }),
          attribute: attribute_reference.attribute
        })
      end

      def visit_qualifier(ctx)
        ctx__attribute_qualifier = ctx.attribute_qualifier
        ctx__group_qualifier = ctx.group_qualifier
        ctx__index_qualifier = ctx.index_qualifier

        visit_if(ctx__attribute_qualifier || ctx__group_qualifier || ctx__index_qualifier)
      end

      def visit_query_expression(ctx)
        ctx__variable_id = ctx.variable_id
        ctx__aggregate_source = ctx.aggregate_source
        ctx__logical_expression = ctx.logical_expression

        id = visit_if(ctx__variable_id)
        aggregate_source = visit_if(ctx__aggregate_source)
        expression = visit_if(ctx__logical_expression)

        Model::Expressions::QueryExpression.new({
          id: id,
          aggregate_source: aggregate_source,
          expression: expression
        })
      end

      def visit_real_type(ctx)
        ctx__precision_spec = ctx.precision_spec

        precision = visit_if(ctx__precision_spec)

        Model::Types::Real.new({
          precision: precision
        })
      end

      def visit_redeclared_attribute(ctx)
        raise 'Invalid state'
      end

      def visit_referenced_attribute(ctx)
        ctx__attribute_ref = ctx.attribute_ref
        ctx__qualified_attribute = ctx.qualified_attribute

        visit_if(ctx__attribute_ref || ctx__qualified_attribute)
      end

      def visit_reference_clause(ctx)
        ctx__schema_ref = ctx.schema_ref
        ctx__resource_or_rename = ctx.resource_or_rename

        schema = visit_if(ctx__schema_ref)
        items = visit_if_map(ctx__resource_or_rename)

        Model::Interface.new({
          kind: Model::Interface::REFERENCE,
          schema: schema,
          items: items
        })
      end

      def visit_rel_op(ctx)
        ctx__text = ctx.text
        ctx__LESS_THAN = ctx__text == '<'
        ctx__GREATER_THAN = ctx__text == '>'
        ctx__LESS_THAN_OR_EQUAL = ctx__text == '<='
        ctx__GREATER_THAN_OR_EQUAL = ctx__text == '>='
        ctx__NOT_EQUAL = ctx__text == '<>'
        ctx__EQUAL = ctx__text == '='
        ctx__INSTANCE_NOT_EQUAL = ctx__text == ':<>:'
        ctx__INSTANCE_EQUAL = ctx__text == ':=:'

        if ctx__LESS_THAN
          Model::Expressions::BinaryExpression::LESS_THAN
        elsif ctx__GREATER_THAN
          Model::Expressions::BinaryExpression::GREATER_THAN
        elsif ctx__LESS_THAN_OR_EQUAL
          Model::Expressions::BinaryExpression::LESS_THAN_OR_EQUAL
        elsif ctx__GREATER_THAN_OR_EQUAL
          Model::Expressions::BinaryExpression::GREATER_THAN_OR_EQUAL
        elsif ctx__NOT_EQUAL
          Model::Expressions::BinaryExpression::NOT_EQUAL
        elsif ctx__EQUAL
          Model::Expressions::BinaryExpression::EQUAL
        elsif ctx__INSTANCE_NOT_EQUAL
          Model::Expressions::BinaryExpression::INSTANCE_NOT_EQUAL
        elsif ctx__INSTANCE_EQUAL
          Model::Expressions::BinaryExpression::INSTANCE_EQUAL
        else
          raise 'Invalid state'
        end
      end

      def visit_rel_op_extended(ctx)
        ctx__rel_op = ctx.rel_op
        ctx__IN = ctx.IN
        ctx__LIKE = ctx.LIKE

        if ctx__rel_op
          visit(ctx__rel_op)
        elsif ctx__IN
          Model::Expressions::BinaryExpression::IN
        elsif ctx__LIKE
          Model::Expressions::BinaryExpression::LIKE
        else
          raise 'Invalid state'
        end
      end

      def visit_rename_id(ctx)
        ctx__constant_id = ctx.constant_id
        ctx__entity_id = ctx.entity_id
        ctx__function_id = ctx.function_id
        ctx__procedure_id = ctx.procedure_id
        ctx__type_id = ctx.type_id

        visit_if(ctx__constant_id || ctx__entity_id || ctx__function_id || ctx__procedure_id || ctx__type_id)
      end

      def visit_repeat_control(ctx)
        raise 'Invalid state'
      end

      def visit_repeat_stmt(ctx)
        ctx__repeat_control = ctx.repeat_control
        ctx__stmt = ctx.stmt
        ctx__repeat_control__increment_control = ctx__repeat_control&.increment_control
        ctx__repeat_control__increment_control__variable_id = ctx__repeat_control__increment_control&.variable_id
        ctx__repeat_control__increment_control__bound1 = ctx__repeat_control__increment_control&.bound1
        ctx__repeat_control__increment_control__bound2 = ctx__repeat_control__increment_control&.bound2
        ctx__repeat_control__increment_control__increment = ctx__repeat_control__increment_control&.increment
        ctx__repeat_control__while_control = ctx__repeat_control&.while_control
        ctx__repeat_control__until_control = ctx__repeat_control&.until_control

        id = visit_if(ctx__repeat_control__increment_control__variable_id)
        bound1 = visit_if(ctx__repeat_control__increment_control__bound1)
        bound2 = visit_if(ctx__repeat_control__increment_control__bound2)
        increment = visit_if(ctx__repeat_control__increment_control__increment)
        while_expression = visit_if(ctx__repeat_control__while_control)
        until_expression = visit_if(ctx__repeat_control__until_control)
        statements = visit_if_map(ctx__stmt)

        Model::Statements::Repeat.new({
          id: id,
          bound1: bound1,
          bound2: bound2,
          increment: increment,
          while_expression: while_expression,
          until_expression: until_expression,
          statements: statements
        })
      end

      def visit_repetition(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_resource_or_rename(ctx)
        ctx__resource_ref = ctx.resource_ref
        ctx__rename_id = ctx.rename_id

        if ctx__resource_ref
          if ctx__rename_id
            ref = visit(ctx__resource_ref)
            id = visit(ctx__rename_id)

            Model::RenamedRef.new({
              ref: ref,
              id: id
            })
          else
            visit(ctx__resource_ref)
          end
        else
          raise 'Invalid state'
        end
      end

      def visit_resource_ref(ctx)
        ctx__constant_ref = ctx.constant_ref
        ctx__entity_ref = ctx.entity_ref
        ctx__function_ref = ctx.function_ref
        ctx__procedure_ref = ctx.procedure_ref
        ctx__type_ref = ctx.type_ref

        visit_if(ctx__constant_ref || ctx__entity_ref || ctx__function_ref || ctx__procedure_ref || ctx__type_ref)
      end

      def visit_return_stmt(ctx)
        ctx__expression = ctx.expression

        expression = visit_if(ctx__expression)

        Model::Statements::Return.new({
          expression: expression
        })
      end

      def visit_rule_decl(ctx)
        ctx__rule_head = ctx.rule_head
        ctx__algorithm_head = ctx.algorithm_head
        ctx__stmt = ctx.stmt
        ctx__where_clause = ctx.where_clause
        ctx__rule_head__rule_id = ctx__rule_head&.rule_id
        ctx__rule_head__entity_ref = ctx__rule_head&.entity_ref
        ctx__algorithm_head__declaration = ctx__algorithm_head&.declaration
        ctx__algorithm_head__constant_decl = ctx__algorithm_head&.constant_decl
        ctx__algorithm_head__local_decl = ctx__algorithm_head&.local_decl

        id = visit_if(ctx__rule_head__rule_id)
        applies_to = visit_if_map(ctx__rule_head__entity_ref)
        declarations = visit_if_map(ctx__algorithm_head__declaration)
        constants = visit_if(ctx__algorithm_head__constant_decl)
        variables = visit_if(ctx__algorithm_head__local_decl)
        statements = visit_if_map(ctx__stmt)
        where = visit_if(ctx__where_clause)

        Model::Rule.new({
          id: id,
          applies_to: applies_to,
          declarations: declarations,
          constants: constants,
          variables: variables,
          statements: statements,
          where: where
        })
      end

      def visit_rule_head(ctx)
        raise 'Invalid state'
      end

      def visit_rule_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_rule_label_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_schema_body(ctx)
        raise 'Invalid state'
      end

      def visit_schema_body_declaration(ctx)
        ctx__declaration = ctx.declaration
        ctx__rule_decl = ctx.rule_decl

        visit_if(ctx__declaration || ctx__rule_decl)
      end

      def visit_schema_decl(ctx)
        ctx__schema_id = ctx.schema_id
        ctx__schema_version_id = ctx.schema_version_id
        ctx__schema_body = ctx.schema_body
        ctx__schema_body__interface_specification = ctx__schema_body&.interface_specification
        ctx__schema_body__constant_decl = ctx__schema_body&.constant_decl
        ctx__schema_body__schema_body_declaration = ctx__schema_body&.schema_body_declaration

        id = visit_if(ctx__schema_id)
        version = visit_if(ctx__schema_version_id)
        interfaces = visit_if_map(ctx__schema_body__interface_specification)
        constants = visit_if(ctx__schema_body__constant_decl)
        declarations = visit_if_map(ctx__schema_body__schema_body_declaration)

        Model::Schema.new({
          id: id,
          version: version,
          interfaces: interfaces,
          constants: constants,
          declarations: declarations
        })
      end

      def visit_schema_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_schema_version_id(ctx)
        ctx__string_literal = ctx.string_literal

        visit_if(ctx__string_literal)
      end

      def visit_selector(ctx)
        raise 'Invalid state'
      end

      def visit_select_extension(ctx)
        ctx__named_types = ctx.named_types

        visit_if_map(ctx__named_types)
      end

      def visit_select_list(ctx)
        ctx__named_types = ctx.named_types

        visit_if_map(ctx__named_types)
      end

      def visit_select_type(ctx)
        ctx__EXTENSIBLE = ctx.EXTENSIBLE
        ctx__GENERIC_ENTITY = ctx.GENERIC_ENTITY
        ctx__select_list = ctx.select_list
        ctx__select_extension = ctx.select_extension
        ctx__select_extension__type_ref = ctx.select_extension&.type_ref
        ctx__select_extension__select_list = ctx__select_extension&.select_list

        extensible = !!ctx__EXTENSIBLE
        generic_entity = !!ctx__GENERIC_ENTITY
        items = visit_if(ctx__select_list)
        extension_type = visit_if(ctx__select_extension__type_ref)
        extension_items = visit_if(ctx__select_extension__select_list)

        Model::Types::Select.new({
          extensible: extensible,
          generic_entity: generic_entity,
          items: items,
          extension_type: extension_type,
          extension_items: extension_items
        })
      end

      def visit_set_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__instantiable_type)
        
        Model::Types::Set.new({
          bound1: bound1,
          bound2: bound2,
          base_type: base_type
        })
      end

      def visit_simple_expression(ctx)
        ctx__term = ctx.term
        ctx__add_like_op = ctx.add_like_op

        if ctx__term
          if ctx__term.length >= 2
            if ctx__add_like_op and ctx__add_like_op.length == ctx__term.length - 1
              operands = ctx__term.map(&self.method(:visit))
              operators = ctx__add_like_op.map(&self.method(:visit))

              handle_binary_expression(operands, operators)
            else
              raise 'Invalid state'
            end
          elsif ctx__term.length == 1
            visit(ctx__term[0])
          else
            raise 'Invalid state'
          end
        end
      end

      def visit_simple_factor(ctx)
        ctx__aggregate_initializer = ctx.aggregate_initializer
        ctx__entity_constructor = ctx.entity_constructor
        ctx__enumeration_reference = ctx.enumeration_reference
        ctx__interval = ctx.interval
        ctx__query_expression = ctx.query_expression
        ctx__simple_factor_expression = ctx.simple_factor_expression
        ctx__simple_factor_unary_expression = ctx.simple_factor_unary_expression

        visit_if(ctx__aggregate_initializer || ctx__entity_constructor || ctx__enumeration_reference || ctx__interval || ctx__query_expression || ctx__simple_factor_expression || ctx__simple_factor_unary_expression)
      end

      def visit_simple_factor_expression(ctx)
        ctx__expression = ctx.expression
        ctx__primary = ctx.primary
        
        visit_if(ctx__expression || ctx__primary)
      end

      def visit_simple_factor_unary_expression(ctx)
        ctx__unary_op = ctx.unary_op
        ctx__simple_factor_expression = ctx.simple_factor_expression

        operator = visit_if(ctx__unary_op)
        operand = visit_if(ctx__simple_factor_expression)

        Model::Expressions::UnaryExpression.new({
          operator: operator,
          operand: operand
        })
      end

      def visit_simple_types(ctx)
        ctx__binary_type = ctx.binary_type
        ctx__boolean_type = ctx.boolean_type
        ctx__integer_type = ctx.integer_type
        ctx__logical_type = ctx.logical_type
        ctx__number_type = ctx.number_type
        ctx__real_type = ctx.real_type
        ctx__string_type = ctx.string_type

        visit_if(ctx__binary_type || ctx__boolean_type || ctx__integer_type || ctx__logical_type || ctx__number_type || ctx__real_type || ctx__string_type)
      end

      def visit_skip_stmt(ctx)
        Model::Statements::Skip.new
      end

      def visit_stmt(ctx)
        ctx__alias_stmt = ctx.alias_stmt
        ctx__assignment_stmt = ctx.assignment_stmt
        ctx__case_stmt = ctx.case_stmt
        ctx__compound_stmt = ctx.compound_stmt
        ctx__escape_stmt = ctx.escape_stmt
        ctx__if_stmt = ctx.if_stmt
        ctx__null_stmt = ctx.null_stmt
        ctx__procedure_call_stmt = ctx.procedure_call_stmt
        ctx__repeat_stmt = ctx.repeat_stmt
        ctx__return_stmt = ctx.return_stmt
        ctx__skip_stmt = ctx.skip_stmt

        visit_if(ctx__alias_stmt || ctx__assignment_stmt || ctx__case_stmt || ctx__compound_stmt || ctx__escape_stmt || ctx__if_stmt || ctx__null_stmt || ctx__procedure_call_stmt || ctx__repeat_stmt || ctx__return_stmt || ctx__skip_stmt)
      end

      def visit_string_literal(ctx)
        ctx__SimpleStringLiteral = ctx.SimpleStringLiteral
        ctx__EncodedStringLiteral = ctx.EncodedStringLiteral

        if ctx__SimpleStringLiteral
          handle_simple_string_literal(ctx__SimpleStringLiteral)
        elsif ctx__EncodedStringLiteral
          handle_encoded_string_literal(ctx__EncodedStringLiteral)
        else
          raise 'Invalid state'
        end
      end

      def visit_string_type(ctx)
        ctx__width_spec = ctx.width_spec
        ctx__width_spec__width = ctx__width_spec&.width
        ctx__width_spec__FIXED = ctx__width_spec&.FIXED

        width = visit_if(ctx__width_spec__width)
        fixed = !!ctx__width_spec__FIXED

        Model::Types::String.new({
          width: width,
          fixed: fixed
        })
      end

      def visit_subsuper(ctx)
        raise 'Invalid state'
      end

      def visit_subtype_constraint(ctx)
        ctx__supertype_expression = ctx.supertype_expression

        visit_if(ctx__supertype_expression)
      end

      def visit_subtype_constraint_body(ctx)
        raise 'Invalid state'
      end

      def visit_subtype_constraint_decl(ctx)
        ctx__subtype_constraint_head = ctx.subtype_constraint_head
        ctx__subtype_constraint_body = ctx.subtype_constraint_body
        ctx__subtype_constraint_head__subtype_constraint_id = ctx__subtype_constraint_head&.subtype_constraint_id
        ctx__subtype_constraint_head__entity_ref = ctx__subtype_constraint_head&.entity_ref
        ctx__subtype_constraint_body__abstract_supertype = ctx__subtype_constraint_body&.abstract_supertype
        ctx__subtype_constraint_body__total_over = ctx__subtype_constraint_body&.total_over
        ctx__subtype_constraint_body__supertype_expression = ctx__subtype_constraint_body&.supertype_expression

        id = visit_if(ctx__subtype_constraint_head__subtype_constraint_id)
        applies_to = visit_if(ctx__subtype_constraint_head__entity_ref)
        abstract = !!ctx__subtype_constraint_body__abstract_supertype
        total_over = visit_if(ctx__subtype_constraint_body__total_over)
        supertype_expression = visit_if(ctx__subtype_constraint_body__supertype_expression)

        Model::SubtypeConstraint.new({
          id: id,
          applies_to: applies_to,
          abstract: abstract,
          total_over: total_over,
          supertype_expression: supertype_expression
        })
      end

      def visit_subtype_constraint_head(ctx)
        raise 'Invalid state'
      end

      def visit_subtype_constraint_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_subtype_declaration(ctx)
        ctx__entity_ref = ctx.entity_ref

        visit_if_map(ctx__entity_ref)
      end

      def visit_supertype_constraint(ctx)
        raise 'Invalid state'
      end

      def visit_supertype_expression(ctx)
        ctx__supertype_factor = ctx.supertype_factor
        ctx__ANDOR = ctx.ANDOR

        if ctx__supertype_factor
          if ctx__supertype_factor.length >= 2
            if ctx__ANDOR and ctx__ANDOR.length == ctx__supertype_factor.length - 1
              operands = ctx__supertype_factor.map(&self.method(:visit))
              operators = ctx__ANDOR.map{Model::Expressions::BinaryExpression::ANDOR}

              handle_binary_expression(operands, operators)
            else
              raise 'Invalid state'
            end
          elsif ctx__supertype_factor.length == 1
            visit(ctx__supertype_factor[0])
          else
            raise 'Invalid state'
          end
        end
      end

      def visit_supertype_factor(ctx)
        ctx__supertype_term = ctx.supertype_term
        ctx__AND = ctx.AND

        if ctx__supertype_term
          if ctx__supertype_term.length >= 2
            if ctx__AND and ctx__AND.length == ctx__supertype_term.length - 1
              operands = ctx__supertype_term.map(&self.method(:visit))
              operators = ctx__AND.map{Model::Expressions::BinaryExpression::AND}

              handle_binary_expression(operands, operators)
            else
              raise 'Invalid state'
            end
          elsif ctx__supertype_term.length == 1
            visit(ctx__supertype_term[0])
          else
            raise 'Invalid state'
          end
        end
      end

      def visit_supertype_rule(ctx)
        ctx__subtype_constraint = ctx.subtype_constraint

        visit_if(ctx__subtype_constraint)
      end

      def visit_supertype_term(ctx)
        ctx__entity_ref = ctx.entity_ref
        ctx__one_of = ctx.one_of
        ctx__supertype_expression = ctx.supertype_expression

        visit_if(ctx__entity_ref || ctx__one_of || ctx__supertype_expression)
      end

      def visit_syntax(ctx)
        ctx__schema_decl = ctx.schema_decl

        schemas = visit_if_map(ctx__schema_decl)

        Model::Repository.new({
          schemas: schemas
        })
      end

      def visit_term(ctx)
        ctx__factor = ctx.factor
        ctx__multiplication_like_op = ctx.multiplication_like_op

        if ctx__factor
          if ctx__factor.length >= 2
            if ctx__multiplication_like_op and ctx__multiplication_like_op.length == ctx__factor.length - 1
              operands = ctx__factor.map(&self.method(:visit))
              operators = ctx__multiplication_like_op.map(&self.method(:visit))

              handle_binary_expression(operands, operators)
            else
              raise 'Invalid state'
            end
          elsif ctx__factor.length == 1
            visit(ctx__factor[0])
          else
            raise 'Invalid state'
          end
        end
      end

      def visit_total_over(ctx)
        ctx__entity_ref = ctx.entity_ref

        visit_if_map(ctx__entity_ref)
      end

      def visit_type_decl(ctx)
        ctx__type_id = ctx.type_id
        ctx__underlying_type = ctx.underlying_type
        ctx__where_clause = ctx.where_clause

        id = visit_if(ctx__type_id)
        type = visit_if(ctx__underlying_type)
        where = visit_if(ctx__where_clause)

        Model::Type.new({
          id: id,
          type: type,
          where: where
        })
      end

      def visit_type_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_type_label(ctx)
        ctx__type_label_id = ctx.type_label_id
        ctx__type_label_ref = ctx.type_label_ref

        visit_if(ctx__type_label_id || ctx__type_label_ref)
      end

      def visit_type_label_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_unary_op(ctx)
        ctx__text = ctx.text
        ctx__PLUS = ctx__text == '+'
        ctx__MINUS = ctx__text == '-'
        ctx__NOT = ctx.NOT

        if ctx__PLUS
          Model::Expressions::UnaryExpression::PLUS
        elsif ctx__MINUS
          Model::Expressions::UnaryExpression::MINUS
        elsif ctx__NOT
          Model::Expressions::UnaryExpression::NOT
        else
          raise 'Invalid state'
        end
      end

      def visit_underlying_type(ctx)
        ctx__concrete_types = ctx.concrete_types
        ctx__constructed_types = ctx.constructed_types

        visit_if(ctx__concrete_types || ctx__constructed_types)
      end

      def visit_unique_clause(ctx)
        ctx__unique_rule = ctx.unique_rule

        visit_if_map(ctx__unique_rule)
      end

      def visit_unique_rule(ctx)
        ctx__rule_label_id = ctx.rule_label_id
        ctx__referenced_attribute = ctx.referenced_attribute

        id = visit_if(ctx__rule_label_id)
        attributes = visit_if_map(ctx__referenced_attribute)

        Model::Unique.new({
          id: id,
          attributes: attributes
        })
      end

      def visit_until_control(ctx)
        ctx__logical_expression = ctx.logical_expression

        visit_if(ctx__logical_expression)
      end

      def visit_use_clause(ctx)
        ctx__schema_ref = ctx.schema_ref
        ctx__named_type_or_rename = ctx.named_type_or_rename

        schema = visit_if(ctx__schema_ref)
        items = visit_if_map(ctx__named_type_or_rename)

        Model::Interface.new({
          kind: Model::Interface::USE,
          schema: schema,
          items: items
        })
      end

      def visit_variable_id(ctx)
        ctx__SimpleId = ctx.SimpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_where_clause(ctx)
        ctx__domain_rule = ctx.domain_rule

        visit_if_map(ctx__domain_rule)
      end

      def visit_while_control(ctx)
        ctx__logical_expression = ctx.logical_expression

        visit_if(ctx__logical_expression)
      end

      def visit_width(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_width_spec(ctx)
        raise 'Invalid state'
      end

      private

      def handle_binary_expression(operands, operators)
        if operands.length != operators.length + 1
          raise 'Invalid state'
        end

        expression = Model::Expressions::BinaryExpression.new({
          operator: operators[0],
          operand1: operands[0],
          operand2: operands[1]
        })
        operators[1..(operators.length - 1)].each_with_index do |operator, i|
          expression = Model::Expressions::BinaryExpression.new({
            operator: operator,
            operand1: expression,
            operand2: operands[i + 2]
          })
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

            Model::Expressions::AttributeReference.new({
              ref: ref,
              attribute: attribute_reference.attribute
            })
          elsif ctx__group_qualifier
            group_reference = visit_if(ctx__group_qualifier)

            Model::Expressions::GroupReference.new({
              ref: ref,
              entity: group_reference.entity
            })
          elsif ctx__index_qualifier
            index_reference = visit_if(ctx__index_qualifier)

            Model::Expressions::IndexReference.new({
              ref: ref,
              index1: index_reference.index1,
              index2: index_reference.index2
            })
          else
            raise 'Invalid state'
          end
        end
      end

      def handle_binary_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text[1..(ctx__text.length - 1)]

        Model::Literals::Binary.new({
          value: value
        })
      end

      def handle_integer_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text

        Model::Literals::Integer.new({
          value: value
        })
      end

      def handle_real_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text

        Model::Literals::Real.new({
          value: value
        })
      end

      def handle_simple_id(ctx)
        ctx__text = ctx.text

        ctx__text
      end

      def handle_simple_string_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text[1..(ctx__text.length - 2)].force_encoding('UTF-8')

        Model::Literals::String.new({
          value: value
        })
      end

      def handle_encoded_string_literal(ctx)
        ctx__text = ctx.text

        value = ctx__text[1..(ctx__text.length - 2)].force_encoding('UTF-8')

        Model::Literals::String.new({
          value: value,
          encoded: true
        })
      end
    end
  end
end