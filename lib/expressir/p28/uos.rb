# frozen_string_literal: true

module Expressir
  module P28
    # The unit of serialization writer (TODO.p28/01): a P21-shaped
    # population emitted as a clause 9.2.2 uos element using the
    # default binding (clause 7) encoding rules of clause 9.
    #
    # Encoding summary (clause ids cited at each rule):
    # - every instance is a by-value entity instance element
    #   (9.3.1), named by the entity id with its first letter
    #   uppercased (8.5.5 identifier conversion; 9.2.6.1 worked
    #   example `car_model` -> `Car_model`), carrying `id="id<n>"`;
    # - instance elements sit in the schema's target namespace;
    #   attribute accessor elements are unprefixed, matching the
    #   clause 9 worked example;
    # - explicit attributes become child elements (9.3.1.1):
    #   booleans `true`/`false` (9.5.2), logicals
    #   `true`/`false`/`unknown` (9.5.4), integers per xs:integer
    #   (9.5.3), enumeration items as their declared string (9.6.1),
    #   binaries as hexBinary (9.5.1), entity references as a
    #   by-reference accessor with `ref` (9.3.3), `$` omits the
    #   element (the P21 validator owns mandatory-presence
    #   findings), aggregates of simple base as whitespace LIST
    #   text (9.8.1), aggregates of entity base as one child per
    #   component, each named and referenced by its target instance
    #   (9.2.6.1 worked example `Control_points`);
    # - complex entities become `exp:complexEntity` (9.3.4) with
    #   one by-value child per supertype component.
    module Uos
      module_function

      # @param population [P21::Population]
      # @param schema [Model::Declarations::Schema]
      # @param id [String] the uos id attribute
      # @param target_namespace [String] the schema's target
      #   namespace URI (clause 7: preprocessor-chosen)
      # @param prefix [String] the namespace prefix for instance
      #   elements (clause 7: preprocessor-chosen)
      # @return [String] the serialized uos document
      def emit(population, schema, id: "uos01",
               target_namespace: P28.default_target_namespace(schema.id),
               prefix: default_prefix(schema))
        ctx = Moxml::Context.new
        doc = ctx.create_document
        uos = doc.create_element("uos")
        uos.set_attributes(
          "id" => id,
          "express" => schema.id,
          "xmlns:#{prefix}" => target_namespace,
          "xmlns:exp" => COMMON_NS,
        )
        doc.add_child(uos)
        slots = Eval::Environment.new(schema: schema)
        population.instances.each do |pid, record|
          uos.add_child(instance_element(doc, schema, slots, prefix,
                                         population, pid, record))
        end
        doc.to_xml
      end

      # A deterministic preprocessor-chosen prefix: the initials of
      # the schema name's words (car_ownership -> "co").
      def default_prefix(schema)
        schema.id.to_s.split("_").filter_map { |word| word[0] }.join.downcase
      end

      # 8.5.5 identifier conversion: uppercase the first character.
      def element_name(express_id)
        express_id.to_s.sub(/\A[a-z]/, &:upcase)
      end

      # Part 21 keywords are stored uppercased; the XML element name
      # derives from the EXPRESS declaration id (8.5.5), falling back
      # to the downcased keyword when the schema has no declaration.
      def instance_name(entity, keyword)
        element_name(entity ? entity.id : keyword.to_s.downcase)
      end

      def instance_element(doc, schema, slots, prefix, population, pid, record)
        if record.is_a?(P21::ComplexRecord)
          return complex_entity_element(doc, schema, slots, prefix,
                                        population, pid, record)
        end

        entity = find_entity(schema, record.keyword)
        node = doc.create_element(
          "#{prefix}:#{instance_name(entity, record.keyword)}",
        )
        node.set_attributes("id" => instance_id(pid))
        record.params.each_with_index do |value, index|
          name = entity ? attribute_name(slots, entity, index) : nil
          element = attribute_value_element(doc, name, value, population)
          node.add_child(element) if element
        end
        node
      end

      # 9.3.4: one by-value child per supertype component; the id
      # rides the complexEntity element.
      def complex_entity_element(doc, schema, slots, prefix, population,
                                 pid, record)
        node = doc.create_element("exp:complexEntity")
        node.set_attributes("id" => instance_id(pid))
        record.records.each do |part|
          entity = find_entity(schema, part.keyword)
          child = doc.create_element(
            "#{prefix}:#{instance_name(entity, part.keyword)}",
          )
          part.params.each_with_index do |value, index|
            name = entity ? attribute_name(slots, entity, index) : nil
            element = attribute_value_element(doc, name, value, population)
            child.add_child(element) if element
          end
          node.add_child(child)
        end
        node
      end

      def attribute_value_element(doc, name, value, population)
        case value
        when Array then aggregate_element(doc, name, value, population)
        when P21::TypedValue then typed_element(doc, value, population)
        when :unset, :derived then nil
        when String then reference_or_string_element(doc, name, value,
                                                     population)
        when P21::Enumeration
          # Part 21 encodes logicals/booleans as .T./.F./.UNKNOWN.
          # (Part 21 7.5.3); the parser hands them to us as
          # Enumerations. Re-encode per 9.5.2/9.5.4; genuine
          # enumeration items pass through as their text (9.6.1).
          text_element(doc, name, logical_text(value.name))
        when P21::Binary
          text_element(doc, name, value.hex) # 9.5.1 hexBinary
        else
          # 9.5.2 booleans, 9.5.3/9.5.5 numerics, plain strings
          text_element(doc, name, value.to_s)
        end
      end

      # 9.3.3: a reference value is a by-reference accessor named
      # after the attribute; a string value is a text accessor.
      def reference_or_string_element(doc, name, value, _population)
        return text_element(doc, name, value) unless value.start_with?("#")

        node = doc.create_element(name ? element_name(name) : "Ref")
        node.set_attributes("ref" => instance_id(value))
        node
      end

      # 9.8.1: aggregates of simple base types are one whitespace
      # LIST text value; entity-based aggregates carry one child per
      # component, named by the component's entity type and
      # referenced (9.2.6.1 worked example `Control_points`).
      def aggregate_element(doc, name, values, population)
        node = doc.create_element(name ? element_name(name) : "List")
        if values.all? { |v| v.is_a?(String) && v.start_with?("#") }
          values.each do |ref|
            keyword = population.instances[ref]&.keyword
            child = doc.create_element(
              keyword ? element_name(keyword.to_s.downcase) : "Ref",
            )
            child.set_attributes("ref" => instance_id(ref))
            node.add_child(child)
          end
        else
          node.content = values.map { |v| scalar_text(v) }.join(" ")
        end
        node
      end

      # A typed parameter (KEYWORD(values)) is emitted as the
      # capitalized keyword element wrapping its values.
      def typed_element(doc, value, population)
        node = doc.create_element(element_name(value.keyword))
        value.value.each do |item|
          element = attribute_value_element(doc, nil, item, population)
          node.add_child(element) if element
        end
        node
      end

      def text_element(doc, name, text)
        node = doc.create_element(name ? element_name(name) : "Value")
        node.content = text.to_s
        node
      end

      def logical_text(name)
        case name.to_s.upcase
        when "T" then "true"
        when "F" then "false"
        when "UNKNOWN" then "unknown"
        else name.to_s
        end
      end

      def scalar_text(value)
        case value
        when P21::Enumeration then logical_text(value.name)
        when P21::Binary then value.hex
        when :unset, :derived then ""
        else value.to_s
        end
      end

      def instance_id(pid)
        "id#{pid.to_s.delete_prefix('#')}"
      end

      # The Part 21 slot's attribute name: inherited explicit
      # attributes first (supertype closure order), the same
      # contract the P21 validator maps values by.
      def attribute_name(slots, entity, index)
        name_for_slot = slots.slots_for(entity).find { |_, slot| slot == index }
        name_for_slot&.first
      end

      def find_entity(schema, keyword)
        Array(schema.entities).find do |entity|
          entity.id&.safe_downcase == keyword&.safe_downcase
        end
      end
    end
  end
end
