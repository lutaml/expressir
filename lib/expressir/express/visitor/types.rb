# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module Types
        private

      def visit_aggregate_type(ctx)
        ctx__type_label = ctx.type_label
        ctx__parameter_type = ctx.parameter_type

        id = visit_if(ctx__type_label)
        base_type = visit_if(ctx__parameter_type)

        Model::DataTypes::Aggregate.new(
          id: id,
          base_type: base_type,
        )
      end

      def visit_aggregation_types(ctx)
        ctx__array_type = ctx.array_type
        ctx__bag_type = ctx.bag_type
        ctx__list_type = ctx.list_type
        ctx__set_type = ctx.set_type

        visit_if(ctx__array_type || ctx__bag_type || ctx__list_type || ctx__set_type)
      end

      def visit_array_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__OPTIONAL = ctx.tOPTIONAL
        ctx__UNIQUE = ctx.tUNIQUE
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        optional = ctx__OPTIONAL && true
        unique = ctx__UNIQUE && true
        base_type = visit_if(ctx__instantiable_type)

        Model::DataTypes::Array.new(
          bound1: bound1,
          bound2: bound2,
          optional: optional,
          unique: unique,
          base_type: base_type,
        )
      end

      def visit_bag_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__instantiable_type)

        Model::DataTypes::Bag.new(
          bound1: bound1,
          bound2: bound2,
          base_type: base_type,
        )
      end

      def visit_binary_type(ctx)
        ctx__width_spec = ctx.width_spec
        ctx__width_spec__width = ctx__width_spec&.width
        ctx__width_spec__FIXED = ctx__width_spec&.tFIXED

        width = visit_if(ctx__width_spec__width)
        fixed = ctx__width_spec__FIXED && true

        Model::DataTypes::Binary.new(
          width: width,
          fixed: fixed,
        )
      end

      def visit_boolean_type(_ctx)
        Model::DataTypes::Boolean.new
      end

      def visit_concrete_types(ctx)
        ctx__aggregation_types = ctx.aggregation_types
        ctx__simple_types = ctx.simple_types
        ctx__type_ref = ctx.type_ref

        visit_if(ctx__aggregation_types || ctx__simple_types || ctx__type_ref)
      end

      def visit_constructed_types(ctx)
        ctx__enumeration_type = ctx.enumeration_type
        ctx__select_type = ctx.select_type

        visit_if(ctx__enumeration_type || ctx__select_type)
      end

      def visit_enumeration_extension(_ctx)
        raise Error::VisitorInvalidStateError.new("visit_enumeration_extension called with invalid context")
      end

      def visit_enumeration_items(ctx)
        ctx__enumeration_item = ctx.enumeration_item

        visit_if_map(ctx__enumeration_item)
      end

      def visit_enumeration_item(ctx)
        ctx__enumeration_id = ctx.enumeration_id

        id = visit_if(ctx__enumeration_id)

        Model::DataTypes::EnumerationItem.new(
          id: id,
        )
      end

      def visit_enumeration_reference(ctx)
        ctx__type_ref = ctx.type_ref
        ctx__enumeration_ref = ctx.enumeration_ref

        if ctx__type_ref
          ref = visit_if(ctx__type_ref)
          attribute = visit_if(ctx__enumeration_ref)

          Model::References::AttributeReference.new(
            ref: ref,
            attribute: attribute,
          )
        else
          visit_if(ctx__enumeration_ref)
        end
      end

      def visit_enumeration_type(ctx)
        ctx__EXTENSIBLE = ctx.tEXTENSIBLE
        ctx__enumeration_items = ctx.enumeration_items
        ctx__enumeration_extension = ctx.enumeration_extension
        ctx__enumeration_extension__type_ref = ctx__enumeration_extension&.type_ref
        ctx__enumeration_extension__enumeration_items = ctx__enumeration_extension&.enumeration_items

        extensible = ctx__EXTENSIBLE && true
        based_on = visit_if(ctx__enumeration_extension__type_ref)
        items = visit_if(
          ctx__enumeration_items || ctx__enumeration_extension__enumeration_items, []
        )

        Model::DataTypes::Enumeration.new(
          extensible: extensible,
          based_on: based_on,
          items: items,
        )
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
        ctx__OPTIONAL = ctx.tOPTIONAL
        ctx__UNIQUE = ctx.tUNIQUE
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        optional = ctx__OPTIONAL && true
        unique = ctx__UNIQUE && true
        base_type = visit_if(ctx__parameter_type)

        Model::DataTypes::Array.new(
          bound1: bound1,
          bound2: bound2,
          optional: optional,
          unique: unique,
          base_type: base_type,
        )
      end

      def visit_general_bag_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__parameter_type)

        Model::DataTypes::Bag.new(
          bound1: bound1,
          bound2: bound2,
          base_type: base_type,
        )
      end

      def visit_general_list_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__UNIQUE = ctx.tUNIQUE
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        unique = ctx__UNIQUE && true
        base_type = visit_if(ctx__parameter_type)

        Model::DataTypes::List.new(
          bound1: bound1,
          bound2: bound2,
          unique: unique,
          base_type: base_type,
        )
      end

      def visit_general_set_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__parameter_type = ctx.parameter_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__parameter_type)

        Model::DataTypes::Set.new(
          bound1: bound1,
          bound2: bound2,
          base_type: base_type,
        )
      end

      def visit_generic_entity_type(ctx)
        ctx__type_label = ctx.type_label

        id = visit_if(ctx__type_label)

        Model::DataTypes::GenericEntity.new(
          id: id,
        )
      end

      def visit_generic_type(ctx)
        ctx__type_label = ctx.type_label

        id = visit_if(ctx__type_label)

        Model::DataTypes::Generic.new(
          id: id,
        )
      end

      def visit_instantiable_type(ctx)
        ctx__concrete_types = ctx.concrete_types
        ctx__entity_ref = ctx.entity_ref

        visit_if(ctx__concrete_types || ctx__entity_ref)
      end

      def visit_integer_type(_ctx)
        Model::DataTypes::Integer.new
      end

      def visit_list_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__UNIQUE = ctx.tUNIQUE
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        unique = ctx__UNIQUE && true
        base_type = visit_if(ctx__instantiable_type)

        Model::DataTypes::List.new(
          bound1: bound1,
          bound2: bound2,
          unique: unique,
          base_type: base_type,
        )
      end

      def visit_logical_type(_ctx)
        Model::DataTypes::Logical.new
      end

      def visit_named_types(ctx)
        ctx__entity_ref = ctx.entity_ref
        ctx__type_ref = ctx.type_ref

        visit_if(ctx__entity_ref || ctx__type_ref)
      end

      def visit_number_type(_ctx)
        Model::DataTypes::Number.new
      end

      def visit_parameter_type(ctx)
        ctx__generalized_types = ctx.generalized_types
        ctx__named_types = ctx.named_types
        ctx__simple_types = ctx.simple_types

        visit_if(ctx__generalized_types || ctx__named_types || ctx__simple_types)
      end

      def visit_real_type(ctx)
        ctx__precision_spec = ctx.precision_spec

        precision = visit_if(ctx__precision_spec)

        Model::DataTypes::Real.new(
          precision: precision,
        )
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
        ctx__EXTENSIBLE = ctx.tEXTENSIBLE
        ctx__GENERIC_ENTITY = ctx.tGENERIC_ENTITY
        ctx__select_list = ctx.select_list
        ctx__select_extension = ctx.select_extension
        ctx__select_extension__type_ref = ctx.select_extension&.type_ref
        ctx__select_extension__select_list = ctx__select_extension&.select_list

        extensible = ctx__EXTENSIBLE && true
        generic_entity = ctx__GENERIC_ENTITY && true
        based_on = visit_if(ctx__select_extension__type_ref)
        items = visit_if(
          ctx__select_list || ctx__select_extension__select_list, []
        )

        Model::DataTypes::Select.new(
          extensible: extensible,
          generic_entity: generic_entity,
          based_on: based_on,
          items: items,
        )
      end

      def visit_set_type(ctx)
        ctx__bound_spec = ctx.bound_spec
        ctx__instantiable_type = ctx.instantiable_type
        ctx__bound_spec__bound1 = ctx__bound_spec&.bound1
        ctx__bound_spec__bound2 = ctx__bound_spec&.bound2

        bound1 = visit_if(ctx__bound_spec__bound1)
        bound2 = visit_if(ctx__bound_spec__bound2)
        base_type = visit_if(ctx__instantiable_type)

        Model::DataTypes::Set.new(
          bound1: bound1,
          bound2: bound2,
          base_type: base_type,
        )
      end

      def visit_simple_types(ctx)
        ctx__binary_type = ctx.binary_type
        ctx__boolean_type = ctx.boolean_type
        ctx__integer_type = ctx.integer_type
        ctx__logical_type = ctx.logical_type
        ctx__number_type = ctx.number_type
        ctx__real_type = ctx.real_type
        ctx__string_type = ctx.string_type

        visit_if(ctx__binary_type || ctx__boolean_type || ctx__integer_type ||
                 ctx__logical_type || ctx__number_type || ctx__real_type ||
                 ctx__string_type)
      end

      def visit_string_type(ctx)
        ctx__width_spec = ctx.width_spec
        ctx__width_spec__width = ctx__width_spec&.width
        ctx__width_spec__FIXED = ctx__width_spec&.tFIXED

        width = visit_if(ctx__width_spec__width)
        fixed = ctx__width_spec__FIXED && true

        Model::DataTypes::String.new(
          width: width,
          fixed: fixed,
        )
      end

      def visit_underlying_type(ctx)
        ctx__concrete_types = ctx.concrete_types
        ctx__constructed_types = ctx.constructed_types

        visit_if(ctx__concrete_types || ctx__constructed_types)
      end

      end
    end
  end
end
