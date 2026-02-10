# frozen_string_literal: true

module Expressir
  module Express
    class Visitor
      module References
        private

        # Visit attribute reference
        # @param ctx [Ctx] The context containing the attribute reference
        # @return [Model::References::SimpleReference] The attribute reference
        def visit_attribute_ref(ctx)
          ctx__attribute_id = ctx.attribute_id

          id = visit_if(ctx__attribute_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit constant reference
        # @param ctx [Ctx] The context containing the constant reference
        # @return [Model::References::SimpleReference] The constant reference
        def visit_constant_ref(ctx)
          ctx__constant_id = ctx.constant_id

          id = visit_if(ctx__constant_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit entity reference
        # @param ctx [Ctx] The context containing the entity reference
        # @return [Model::References::SimpleReference] The entity reference
        def visit_entity_ref(ctx)
          ctx__entity_id = ctx.entity_id

          id = visit_if(ctx__entity_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit enumeration reference
        # @param ctx [Ctx] The context containing the enumeration reference
        # @return [Model::References::SimpleReference] The enumeration reference
        def visit_enumeration_ref(ctx)
          ctx__enumeration_id = ctx.enumeration_id

          id = visit_if(ctx__enumeration_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit function reference
        # @param ctx [Ctx] The context containing the function reference
        # @return [Model::References::SimpleReference] The function reference
        def visit_function_ref(ctx)
          ctx__function_id = ctx.function_id

          id = visit_if(ctx__function_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit parameter reference
        # @param ctx [Ctx] The context containing the parameter reference
        # @return [Model::References::SimpleReference] The parameter reference
        def visit_parameter_ref(ctx)
          ctx__parameter_id = ctx.parameter_id

          id = visit_if(ctx__parameter_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit procedure reference
        # @param ctx [Ctx] The context containing the procedure reference
        # @return [Model::References::SimpleReference] The procedure reference
        def visit_procedure_ref(ctx)
          ctx__procedure_id = ctx.procedure_id

          id = visit_if(ctx__procedure_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit rule label reference
        # @param ctx [Ctx] The context containing the rule label reference
        # @return [Model::References::SimpleReference] The rule label reference
        def visit_rule_label_ref(ctx)
          ctx__rule_label_id = ctx.rule_label_id

          id = visit_if(ctx__rule_label_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit rule reference
        # @param ctx [Ctx] The context containing the rule reference
        # @return [Model::References::SimpleReference] The rule reference
        def visit_rule_ref(ctx)
          ctx__rule_id = ctx.rule_id

          id = visit_if(ctx__rule_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit schema reference
        # @param ctx [Ctx] The context containing the schema reference
        # @return [Model::References::SimpleReference] The schema reference
        def visit_schema_ref(ctx)
          ctx__schema_id = ctx.schema_id

          id = visit_if(ctx__schema_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit subtype constraint reference
        # @param ctx [Ctx] The context containing the subtype constraint reference
        # @return [Model::References::SimpleReference] The subtype constraint reference
        def visit_subtype_constraint_ref(ctx)
          ctx__subtype_constraint_id = ctx.subtype_constraint_id

          id = visit_if(ctx__subtype_constraint_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit type label reference
        # @param ctx [Ctx] The context containing the type label reference
        # @return [Model::References::SimpleReference] The type label reference
        def visit_type_label_ref(ctx)
          ctx__type_label_id = ctx.type_label_id

          id = visit_if(ctx__type_label_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit type reference
        # @param ctx [Ctx] The context containing the type reference
        # @return [Model::References::SimpleReference] The type reference
        def visit_type_ref(ctx)
          ctx__type_id = ctx.type_id

          id = visit_if(ctx__type_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Visit variable reference
        # @param ctx [Ctx] The context containing the variable reference
        # @return [Model::References::SimpleReference] The variable reference
        def visit_variable_ref(ctx)
          ctx__variable_id = ctx.variable_id

          id = visit_if(ctx__variable_id)

          Model::References::SimpleReference.new(
            id: id,
          )
        end

        # Handle qualified reference with attribute, group, or index qualifiers
        # @param ref [Object] The base reference
        # @param qualifiers [Array<Ctx>] The qualifiers to apply
        # @return [Object] The qualified reference
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
      end
    end
  end
end
