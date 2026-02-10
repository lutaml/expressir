# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module Declarations
        private

      def visit_abstract_entity_declaration(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_abstract_entity_declaration called with invalid context")
      end

      def visit_abstract_supertype(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_abstract_supertype called with invalid context")
      end

      def visit_abstract_supertype_declaration(ctx)
        ctx__subtype_constraint = ctx.subtype_constraint

        visit_if(ctx__subtype_constraint)
      end

      def visit_actual_parameter_list(ctx)
        ctx__parameter = ctx.parameter

        visit_if_map(ctx__parameter)
      end

      def visit_aggregate_initializer(ctx)
        ctx__element = ctx.element

        items = visit_if_map(ctx__element)

        Model::Expressions::AggregateInitializer.new(
          items: items,
        )
      end

      def visit_aggregate_source(ctx)
        ctx__simple_expression = ctx.simple_expression

        visit_if(ctx__simple_expression)
      end

      def visit_algorithm_head(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_algorithm_head called with invalid context")
      end

      def visit_attribute_decl(ctx)
        ctx__attribute_id = ctx.attribute_id
        ctx__redeclared_attribute = ctx.redeclared_attribute
        ctx__redeclared_attribute__qualified_attribute = ctx__redeclared_attribute&.qualified_attribute
        ctx__redeclared_attribute__attribute_id = ctx__redeclared_attribute&.attribute_id

        attribute_qualifier = ctx__redeclared_attribute__qualified_attribute&.attribute_qualifier
        attribute_id = attribute_qualifier&.attribute_ref&.attribute_id
        ctx__redeclared_attribute__qualified_attribute__attribute_qualifier_attribute_id = attribute_id

        id = visit_if(ctx__attribute_id ||
          ctx__redeclared_attribute__attribute_id ||
            ctx__redeclared_attribute__qualified_attribute__attribute_qualifier_attribute_id)
        supertype_attribute = visit_if(ctx__redeclared_attribute__qualified_attribute)

        Model::Declarations::Attribute.new(
          id: id,
          supertype_attribute: supertype_attribute,
        )
      end

      def visit_attribute_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_attribute_qualifier(ctx)
        ctx__attribute_ref = ctx.attribute_ref

        attribute = visit_if(ctx__attribute_ref)

        Model::References::AttributeReference.new(
          attribute: attribute,
        )
      end

      def visit_attribute_reference(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_attribute_reference called with invalid context")
      end

      def visit_built_in_constant(ctx)
        ctx__text = ctx.values[0].text

        id = ctx__text

        Model::References::SimpleReference.new(
          id: id,
        )
      end

      def visit_built_in_function(ctx)
        ctx__text = ctx.values[0].text

        id = ctx__text

        Model::References::SimpleReference.new(
          id: id,
        )
      end

      def visit_built_in_procedure(ctx)
        ctx__text = ctx.values[0].text

        id = ctx__text

        Model::References::SimpleReference.new(
          id: id,
        )
      end

      def visit_constant_body(ctx)
        ctx__constant_id = ctx.constant_id
        ctx__instantiable_type = ctx.instantiable_type
        ctx__expression = ctx.expression

        id = visit_if(ctx__constant_id)
        type = visit_if(ctx__instantiable_type)
        expression = visit_if(ctx__expression)

        Model::Declarations::Constant.new(
          id: id,
          type: type,
          expression: expression,
        )
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
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
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

        Model::Declarations::DerivedAttribute.new(
          id: attribute.id,
          supertype_attribute: attribute.supertype_attribute, # reuse
          type: type,
          expression: expression,
        )
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

        Model::Declarations::WhereRule.new(
          id: id,
          expression: expression,
        )
      end

      def visit_element(ctx)
        ctx__expression = ctx.expression
        ctx__repetition = ctx.repetition

        if ctx__repetition
          expression = visit_if(ctx__expression)
          repetition = visit_if(ctx__repetition)

          Model::Expressions::AggregateInitializerItem.new(
            expression: expression,
            repetition: repetition,
          )
        else
          visit_if(ctx__expression)
        end
      end

      def visit_entity_body(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_entity_body called with invalid context")
      end

      def visit_entity_decl(ctx)
        ctx__entity_head = ctx.entity_head
        ctx__entity_body = ctx.entity_body
        ctx__entity_head__entity_id = ctx__entity_head&.entity_id
        ctx__entity_head__subsuper = visit_if ctx__entity_head&.subsuper
        ctx__entity_head__subsuper__supertype_constraint = ctx__entity_head__subsuper&.supertype_constraint
        ctx__entity_head__subsuper__supertype_constraint__abstract_entity_declaration =
          ctx__entity_head__subsuper__supertype_constraint&.abstract_entity_declaration
        ctx__entity_head__subsuper__supertype_constraint__abstract_supertype_declaration =
          ctx__entity_head__subsuper__supertype_constraint&.abstract_supertype_declaration
        ctx__entity_head__subsuper__supertype_constraint__supertype_rule = ctx__entity_head__subsuper__supertype_constraint&.supertype_rule
        ctx__entity_head__subsuper__subtype_declaration = ctx__entity_head__subsuper&.subtype_declaration
        ctx__entity_body__explicit_attr = ctx__entity_body&.explicit_attr
        ctx__entity_body__derive_clause = ctx__entity_body&.derive_clause
        ctx__entity_body__inverse_clause = ctx__entity_body&.inverse_clause
        ctx__entity_body__unique_clause = ctx__entity_body&.unique_clause
        ctx__entity_body__where_clause = ctx__entity_body&.where_clause

        id = visit_if(ctx__entity_head__entity_id)
        abstract = (ctx__entity_head__subsuper__supertype_constraint__abstract_entity_declaration ||
                    ctx__entity_head__subsuper__supertype_constraint__abstract_supertype_declaration) && true
        supertype_expression = visit_if(ctx__entity_head__subsuper__supertype_constraint__abstract_supertype_declaration ||
                                        ctx__entity_head__subsuper__supertype_constraint__supertype_rule)
        subtype_of = visit_if(ctx__entity_head__subsuper__subtype_declaration,
                              [])
        attributes = [
          *visit_if_map_flatten(ctx__entity_body__explicit_attr),
          *visit_if(ctx__entity_body__derive_clause),
          *visit_if(ctx__entity_body__inverse_clause),
        ]
        unique_rules = visit_if(ctx__entity_body__unique_clause, [])
        where_rules = visit_if(ctx__entity_body__where_clause, [])

        Model::Declarations::Entity.new(
          id: id,
          abstract: abstract,
          supertype_expression: supertype_expression,
          subtype_of: subtype_of,
          attributes: attributes,
          unique_rules: unique_rules,
          where_rules: where_rules,
        )
      end

      def visit_entity_head(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_entity_head called with invalid context")
      end

      def visit_entity_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_enumeration_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_explicit_attr(ctx)
        ctx__attribute_decl = ctx.attribute_decl
        ctx__OPTIONAL = ctx.tOPTIONAL
        ctx__parameter_type = ctx.parameter_type

        attributes = visit_if_map(ctx__attribute_decl)
        optional = ctx__OPTIONAL && true
        type = visit_if(ctx__parameter_type)

        attributes.map do |attribute|
          Model::Declarations::Attribute.new(
            id: attribute.id, # reuse
            kind: Model::Declarations::Attribute::EXPLICIT,
            supertype_attribute: attribute.supertype_attribute, # reuse
            optional: optional,
            type: type,
          )
        end
      end

      def visit_formal_parameter(ctx)
        ctx__parameter_id = ctx.parameter_id
        ctx__parameter_type = ctx.parameter_type

        ids = visit_if_map(ctx__parameter_id)
        type = visit_if(ctx__parameter_type)

        ids.map do |id|
          Model::Declarations::Parameter.new(
            id: id,
            type: type,
          )
        end
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
        types = declarations.select { |x| x.is_a? Model::Declarations::Type }
        entities = declarations.select do |x|
          x.is_a? Model::Declarations::Entity
        end
        subtype_constraints = declarations.select do |x|
          x.is_a? Model::Declarations::SubtypeConstraint
        end
        functions = declarations.select do |x|
          x.is_a? Model::Declarations::Function
        end
        procedures = declarations.select do |x|
          x.is_a? Model::Declarations::Procedure
        end
        constants = visit_if(ctx__algorithm_head__constant_decl, [])
        variables = visit_if(ctx__algorithm_head__local_decl, [])
        statements = visit_if_map(ctx__stmt)

        Model::Declarations::Function.new(
          id: id,
          parameters: parameters,
          return_type: return_type,
          types: types,
          entities: entities,
          subtype_constraints: subtype_constraints,
          functions: functions,
          procedures: procedures,
          constants: constants,
          variables: variables,
          statements: statements,
        )
      end

      def visit_function_head(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_function_head called with invalid context")
      end

      def visit_function_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_group_qualifier(ctx)
        ctx__entity_ref = ctx.entity_ref

        entity = visit_if(ctx__entity_ref)

        Model::References::GroupReference.new(
          entity: entity,
        )
      end

      def visit_group_reference(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_group_reference called with invalid context")
      end

      def visit_increment(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_increment_control(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_increment_control called with invalid context")
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

        Model::References::IndexReference.new(
          index1: index1,
          index2: index2,
        )
      end

      def visit_index_reference(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_index_reference called with invalid context")
      end

      def visit_interface_specification(ctx)
        ctx__reference_clause = ctx.reference_clause
        ctx__use_clause = ctx.use_clause

        visit_if(ctx__reference_clause || ctx__use_clause)
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

                       Model::References::AttributeReference.new(
                         ref: ref,
                         attribute: attribute_ref,
                       )
                     else
                       visit(ctx__attribute_ref)
                     end

        Model::Declarations::InverseAttribute.new(
          id: attribute.id, # reuse
          supertype_attribute: attribute.supertype_attribute, # reuse
          type: type,
          expression: expression,
        )
      end

      def visit_inverse_attr_type(ctx)
        ctx__SET = ctx.tSET
        ctx__BAG = ctx.tBAG
        ctx__bound_spec = ctx.bound_spec
        ctx__entity_ref = ctx.entity_ref
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        if ctx__SET
          bound1 = visit_if(ctx__bound_spec__bound1)
          bound2 = visit_if(ctx__bound_spec__bound2)
          base_type = visit_if(ctx__entity_ref)

          Model::DataTypes::Set.new(
            bound1: bound1,
            bound2: bound2,
            base_type: base_type,
          )
        elsif ctx__BAG
          bound1 = visit_if(ctx__bound_spec__bound1)
          bound2 = visit_if(ctx__bound_spec__bound2)
          base_type = visit_if(ctx__entity_ref)

          Model::DataTypes::Bag.new(
            bound1: bound1,
            bound2: bound2,
            base_type: base_type,
          )
        else
          visit_if(ctx__entity_ref)
        end
      end

      def visit_inverse_clause(ctx)
        ctx__inverse_attr = ctx.inverse_attr

        visit_if_map(ctx__inverse_attr)
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
          Model::Declarations::Variable.new(
            id: id,
            type: type,
            expression: expression,
          )
        end
      end

      def visit_named_type_or_rename(ctx)
        ctx__named_types = ctx.named_types
        ctx__entity_id = ctx.entity_id
        ctx__type_id = ctx.type_id

        ref = visit_if(ctx__named_types)
        id = visit_if(ctx__entity_id || ctx__type_id)

        Model::Declarations::InterfaceItem.new(
          ref: ref,
          id: id,
        )
      end

      def visit_numeric_expression(ctx)
        ctx__simple_expression = ctx.simple_expression

        visit_if(ctx__simple_expression)
      end

      def visit_one_of(ctx)
        ctx__supertype_expression = ctx.supertype_expression

        operands = visit_if_map(ctx__supertype_expression)

        Model::SupertypeExpressions::OneofSupertypeExpression.new(
          operands: operands,
        )
      end

      def visit_parameter_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_population(ctx)
        ctx__entity_ref = ctx.entity_ref

        visit_if(ctx__entity_ref)
      end

      def visit_precision_spec(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
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
        types = declarations.select { |x| x.is_a? Model::Declarations::Type }
        entities = declarations.select do |x|
          x.is_a? Model::Declarations::Entity
        end
        subtype_constraints = declarations.select do |x|
          x.is_a? Model::Declarations::SubtypeConstraint
        end
        functions = declarations.select do |x|
          x.is_a? Model::Declarations::Function
        end
        procedures = declarations.select do |x|
          x.is_a? Model::Declarations::Procedure
        end
        constants = visit_if(ctx__algorithm_head__constant_decl, [])
        variables = visit_if(ctx__algorithm_head__local_decl, [])
        statements = visit_if_map(ctx__stmt)

        Model::Declarations::Procedure.new(
          id: id,
          parameters: parameters,
          types: types,
          entities: entities,
          subtype_constraints: subtype_constraints,
          functions: functions,
          procedures: procedures,
          constants: constants,
          variables: variables,
          statements: statements,
        )
      end

      def visit_procedure_head(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_procedure_head called with invalid context")
      end

      def visit_procedure_head_parameter(ctx)
        ctx__formal_parameter = ctx.formal_parameter
        ctx.tVAR

        parameters = visit(ctx__formal_parameter)

        if ctx.tVAR
          parameters.map do |parameter|
            Model::Declarations::Parameter.new(
              id: parameter.id,
              var: true,
              type: parameter.type,
            )
          end
        else
          parameters
        end
      end

      def visit_procedure_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_qualifier(ctx)
        ctx__attribute_qualifier = ctx.attribute_qualifier
        ctx__group_qualifier = ctx.group_qualifier
        ctx__index_qualifier = ctx.index_qualifier

        visit_if(ctx__attribute_qualifier || ctx__group_qualifier || ctx__index_qualifier)
      end

      def visit_redeclared_attribute(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_redeclared_attribute called with invalid context")
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

        Model::Declarations::Interface.new(
          kind: Model::Declarations::Interface::REFERENCE,
          schema: schema,
          items: items,
        )
      end

      def visit_rename_id(ctx)
        ctx__constant_id = ctx.constant_id
        ctx__entity_id = ctx.entity_id
        ctx__function_id = ctx.function_id
        ctx__procedure_id = ctx.procedure_id
        ctx__type_id = ctx.type_id

        visit_if(ctx__constant_id || ctx__entity_id || ctx__function_id || ctx__procedure_id || ctx__type_id)
      end

      def visit_repetition(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_resource_or_rename(ctx)
        ctx__resource_ref = ctx.resource_ref
        ctx__rename_id = ctx.rename_id

        ref = visit_if(ctx__resource_ref)
        id = visit_if(ctx__rename_id)

        Model::Declarations::InterfaceItem.new(
          ref: ref,
          id: id,
        )
      end

      def visit_resource_ref(ctx)
        ctx__constant_ref = ctx.constant_ref
        ctx__entity_ref = ctx.entity_ref
        ctx__function_ref = ctx.function_ref
        ctx__procedure_ref = ctx.procedure_ref
        ctx__type_ref = ctx.type_ref

        visit_if(ctx__constant_ref || ctx__entity_ref || ctx__function_ref || ctx__procedure_ref || ctx__type_ref)
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
        types = declarations.select { |x| x.is_a? Model::Declarations::Type }
        entities = declarations.select do |x|
          x.is_a? Model::Declarations::Entity
        end
        subtype_constraints = declarations.select do |x|
          x.is_a? Model::Declarations::SubtypeConstraint
        end
        functions = declarations.select do |x|
          x.is_a? Model::Declarations::Function
        end
        procedures = declarations.select do |x|
          x.is_a? Model::Declarations::Procedure
        end
        constants = visit_if(ctx__algorithm_head__constant_decl, [])
        variables = visit_if(ctx__algorithm_head__local_decl, [])
        statements = visit_if_map(ctx__stmt)
        where_rules = visit_if(ctx__where_clause, [])

        Model::Declarations::Rule.new(
          id: id,
          applies_to: applies_to,
          types: types,
          entities: entities,
          subtype_constraints: subtype_constraints,
          functions: functions,
          procedures: procedures,
          constants: constants,
          variables: variables,
          statements: statements,
          where_rules: where_rules,
        )
      end

      def visit_rule_head(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_rule_head called with invalid context")
      end

      def visit_rule_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_rule_label_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_schema_body(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_schema_body called with invalid context")
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
        constants = visit_if(ctx__schema_body__constant_decl, [])
        declarations = visit_if_map(ctx__schema_body__schema_body_declaration)
        types = declarations.select { |x| x.is_a? Model::Declarations::Type }
        entities = declarations.select do |x|
          x.is_a? Model::Declarations::Entity
        end
        subtype_constraints = declarations.select do |x|
          x.is_a? Model::Declarations::SubtypeConstraint
        end
        functions = declarations.select do |x|
          x.is_a? Model::Declarations::Function
        end
        rules = declarations.select { |x| x.is_a? Model::Declarations::Rule }
        procedures = declarations.select do |x|
          x.is_a? Model::Declarations::Procedure
        end

        Model::Declarations::Schema.new(
          id: id,
          version: version,
          interfaces: interfaces,
          constants: constants,
          types: types,
          entities: entities,
          subtype_constraints: subtype_constraints,
          functions: functions,
          rules: rules,
          procedures: procedures,
        )
      end

      def visit_schema_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_schema_version_id(ctx)
        ctx__string_literal = ctx.string_literal

        value = visit_if(ctx__string_literal)
        value = value.value

        items = if value.start_with?("{") && value.end_with?("}")
                  parts = value.sub(/^\{/, "").sub(/\}$/, "").split
                  parts.map do |part|
                    if match = part.match(/^(.+)\((\d+)\)$/)
                      Model::Declarations::SchemaVersionItem.new(
                        name: match[1],
                        value: match[2],
                      )
                    elsif /^\d+$/.match?(part)
                      Model::Declarations::SchemaVersionItem.new(
                        value: part,
                      )
                    else
                      Model::Declarations::SchemaVersionItem.new(
                        name: part,
                      )
                    end
                  end
                end

        Model::Declarations::SchemaVersion.new(
          value: value,
          items: items,
        )
      end

      def visit_selector(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_selector called with invalid context")
      end

      def visit_string_literal(ctx)
        ctx__SimpleStringLiteral = ctx.simpleStringLiteral
        ctx__EncodedStringLiteral = ctx.encodedStringLiteral

        if ctx__SimpleStringLiteral
          handle_simple_string_literal(ctx__SimpleStringLiteral)
        elsif ctx__EncodedStringLiteral
          handle_encoded_string_literal(ctx__EncodedStringLiteral)
        else
          raise Error::VisitorInvalidStateError.new("visit_string_literal called with invalid context")
        end
      end

      def visit_subsuper(ctx)
        SimpleCtx === ctx ? to_ctx({}, :subsuper) : ctx
      end

      def visit_subtype_constraint(ctx)
        ctx__supertype_expression = ctx.supertype_expression

        visit_if(ctx__supertype_expression)
      end

      def visit_subtype_constraint_body(ctx)
        SimpleCtx === ctx ? to_ctx({}, :subtypeConstraintBody) : ctx
      end

      def visit_subtype_constraint_decl(ctx)
        ctx__subtype_constraint_head = ctx.subtype_constraint_head
        ctx__subtype_constraint_body = visit ctx.subtype_constraint_body
        ctx__subtype_constraint_head__subtype_constraint_id = ctx__subtype_constraint_head&.subtype_constraint_id
        ctx__subtype_constraint_head__entity_ref = ctx__subtype_constraint_head&.entity_ref
        ctx__subtype_constraint_body__abstract_supertype = ctx__subtype_constraint_body&.abstract_supertype
        ctx__subtype_constraint_body__total_over = ctx__subtype_constraint_body&.total_over
        ctx__subtype_constraint_body__supertype_expression = ctx__subtype_constraint_body&.supertype_expression

        id = visit_if(ctx__subtype_constraint_head__subtype_constraint_id)
        applies_to = visit_if(ctx__subtype_constraint_head__entity_ref)
        abstract = ctx__subtype_constraint_body__abstract_supertype && true
        total_over = visit_if(ctx__subtype_constraint_body__total_over, [])
        supertype_expression = visit_if(ctx__subtype_constraint_body__supertype_expression)

        Model::Declarations::SubtypeConstraint.new(
          id: id,
          applies_to: applies_to,
          abstract: abstract,
          total_over: total_over,
          supertype_expression: supertype_expression,
        )
      end

      def visit_subtype_constraint_head(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_subtype_constraint_head called with invalid context")
      end

      def visit_subtype_constraint_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_subtype_declaration(ctx)
        ctx__entity_ref = ctx.entity_ref

        visit_if_map(ctx__entity_ref)
      end

      def visit_supertype_constraint(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_supertype_constraint called with invalid context")
      end

      def visit_supertype_expression(ctx)
        ctx__supertype_factor = [ctx.supertype_factor] + ctx.rhs.map(&:supertype_factor)
        ctx__ANDOR = ctx.rhs.map { |item| item.operator.values[0] }

        if ctx__supertype_factor
          if ctx__supertype_factor.length >= 2
            if ctx__ANDOR && (ctx__ANDOR.length == ctx__supertype_factor.length - 1)
              operands = ctx__supertype_factor.map { |item| visit(item) }
              operators = ctx__ANDOR.map do
                Model::SupertypeExpressions::BinarySupertypeExpression::ANDOR
              end

              handle_binary_supertype_expression(operands, operators)
            else
              raise Error::VisitorInvalidStateError.new("visit_supertype_expression called with invalid context")
            end
          elsif ctx__supertype_factor.length == 1
            visit(ctx__supertype_factor[0])
          else
            raise Error::VisitorInvalidStateError.new("visit_supertype_expression called with invalid context")
          end
        end
      end

      def visit_supertype_factor(ctx)
        ctx__supertype_term = [ctx.supertype_term] + ctx.rhs.map(&:supertype_term)
        ctx__AND = ctx.rhs.map { |item| item.operator.values[0] }

        if ctx__supertype_term
          if ctx__supertype_term.length >= 2
            if ctx__AND && (ctx__AND.length == ctx__supertype_term.length - 1)
              operands = ctx__supertype_term.map { |item| visit(item) }
              operators = ctx__AND.map do
                Model::SupertypeExpressions::BinarySupertypeExpression::AND
              end

              handle_binary_supertype_expression(operands, operators)
            else
              raise Error::VisitorInvalidStateError.new("visit_supertype_factor called with invalid context")
            end
          elsif ctx__supertype_term.length == 1
            visit(ctx__supertype_term[0])
          else
            raise Error::VisitorInvalidStateError.new("visit_supertype_factor called with invalid context")
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

      def visit_total_over(ctx)
        ctx__entity_ref = ctx.entity_ref

        visit_if_map(ctx__entity_ref)
      end

      def visit_type_decl(ctx)
        ctx__type_id = ctx.type_id
        ctx__underlying_type = ctx.underlying_type
        ctx__where_clause = ctx.where_clause

        id = visit_if(ctx__type_id)
        underlying_type = visit_if(ctx__underlying_type)
        where_rules = visit_if(ctx__where_clause, [])

        Model::Declarations::Type.new(
          id: id,
          underlying_type: underlying_type,
          where_rules: where_rules,
        )
      end

      def visit_type_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_type_label(ctx)
        ctx__type_label_id = ctx.type_label_id
        ctx__type_label_ref = ctx.type_label_ref

        visit_if(ctx__type_label_id || ctx__type_label_ref)
      end

      def visit_type_label_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
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

        Model::Declarations::UniqueRule.new(
          id: id,
          attributes: attributes,
        )
      end

      def visit_use_clause(ctx)
        ctx__schema_ref = ctx.schema_ref
        ctx__named_type_or_rename = ctx.named_type_or_rename

        schema = visit_if(ctx__schema_ref)
        items = visit_if_map(ctx__named_type_or_rename)

        Model::Declarations::Interface.new(
          kind: Model::Declarations::Interface::USE,
          schema: schema,
          items: items,
        )
      end

      def visit_variable_id(ctx)
        ctx__SimpleId = ctx.simpleId

        handle_simple_id(ctx__SimpleId)
      end

      def visit_where_clause(ctx)
        ctx__domain_rule = ctx.domain_rule

        visit_if_map(ctx__domain_rule)
      end

      def visit_width(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_width_spec(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_width_spec called with invalid context")
      end

      def visit_bound1(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_bound2(ctx)
        ctx__numeric_expression = ctx.numeric_expression

        visit_if(ctx__numeric_expression)
      end

      def visit_bound_spec(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_bound_spec called with invalid context")
      end

      end
    end
  end
end
