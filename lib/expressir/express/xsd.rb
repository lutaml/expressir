# frozen_string_literal: true

module Expressir
  module Express
    # EXPRESS → XML Schema writer (expressir #276 step 2,
    # TODO.parity-ee 15) — the express2xsd counterpart, built on
    # moxml.
    #
    # Mapping (v1):
    #   ENTITY      → xs:element + xs:complexType (explicit attributes
    #                 in declaration order); SUBTYPE OF a schema-local
    #                 entity becomes a substitutionGroup reference.
    #   ENUMERATION → xs:simpleType with enumeration facets.
    #   SELECT      → xs:element of xs:anyType (full Part 28 select
    #                 mapping is a documented v1 limitation).
    #   defined TYPE over a simple type → xs:simpleType restriction.
    #   attributes  → xs:element inside the complexType sequence;
    #                 LIST/SET/BAG/ARRAY → maxOccurs="unbounded".
    #
    # Built-in EXPRESS types map to XML Schema built-ins (STRING→
    # xs:string, INTEGER→xs:integer, REAL/NUMBER→xs:double,
    # BOOLEAN→xs:boolean, LOGICAL→string restriction, BINARY→
    # xs:hexBinary).
    module Xsd
      BUILTIN_TYPES = {
        "string" => "xs:string",
        "integer" => "xs:integer",
        "real" => "xs:double",
        "number" => "xs:double",
        "boolean" => "xs:boolean",
        "binary" => "xs:hexBinary",
      }.freeze

      AGGREGATES = %w[array list set bag].freeze

      module_function

      # @param schema [Model::Declarations::Schema]
      # @return [String] the serialized xs:schema document
      def format(schema)
        ctx = Moxml::Context.new
        doc = ctx.create_document
        root = doc.create_element("xs:schema")
        root.set_attributes("xmlns:xs" => "http://www.w3.org/2001/XMLSchema",
                            "elementFormDefault" => "qualified")
        doc.add_child(root)
        schema.types.to_a.each { |type| root.add_child(type_node(doc, schema, type)) }
        schema.entities.to_a.each do |entity|
          root.add_child(entity_element(doc, schema, entity))
          root.add_child(entity_type(doc, schema, entity))
        end
        doc.to_xml
      end

      def type_node(doc, schema, type)
        underlying = type.underlying_type
        node = doc.create_element("xs:simpleType")
        node.set_attributes("name" => type.id)
        restriction = doc.create_element("xs:restriction")
        node.add_child(restriction)
        if underlying.is_a?(Expressir::Model::DataTypes::Enumeration)
          restriction.set_attributes("base" => "xs:string")
          underlying.items.to_a.each do |item|
            facet = doc.create_element("xs:enumeration")
            facet.set_attributes("value" => item.id)
            restriction.add_child(facet)
          end
        else
          restriction.set_attributes("base" => xs_type(underlying, schema))
        end
        node
      end

      def entity_element(doc, schema, entity)
        node = doc.create_element("xs:element")
        node.set_attributes("name" => entity.id)
        node.set_attributes("type" => entity.id)
        parent = supertype_name(schema, entity)
        node.set_attributes("substitutionGroup" => parent) if parent
        node
      end

      def entity_type(doc, schema, entity)
        node = doc.create_element("xs:complexType")
        node.set_attributes("name" => entity.id)
        sequence = doc.create_element("xs:sequence")
        node.add_child(sequence)
        entity.attributes.to_a.each do |attr|
          skip = attr.kind == Expressir::Model::Declarations::Attribute::INVERSE ||
            (attr.respond_to?(:derive?) && attr.derive?)
          next if skip

          sequence.add_child(attribute_element(doc, schema, attr))
        end
        node
      end

      def attribute_element(doc, schema, attr)
        node = doc.create_element("xs:element")
        node.set_attributes("name" => attr.id)
        node.set_attributes("type" => xs_type(attr.type, schema))
        kind = attr.type.class.name.split("::").last.downcase
        node.set_attributes("maxOccurs" => "unbounded") if AGGREGATES.include?(kind)
        node
      end

      def xs_type(type, schema)
        if type.is_a?(Expressir::Model::References::SimpleReference)
          id = type.respond_to?(:base_path) && type.base_path ? base_id(type.base_path) : type.id
          return schema.types.to_a.any? { |t| t.id.safe_downcase == id.safe_downcase } ? id : "xs:anyType"
        end

        if type.is_a?(Expressir::Model::DataTypes::Enumeration)
          return type.id || "xs:string"
        end

        if type.respond_to?(:base_type)
          inner = type.base_type
          return xs_type(inner, schema) if inner

          return "xs:anyType"
        end

        name = type.class.name.split("::").last.downcase
        BUILTIN_TYPES.fetch(name, "xs:anyType")
      end

      def supertype_name(schema, entity)
        ref = Array(entity.subtype_of).first
        return nil unless ref

        id = ref.is_a?(String) ? ref : ref.id
        return nil unless id
        return nil unless schema.entities.to_a.any? { |e| e.id.safe_downcase == id.safe_downcase }

        schema.entities.find { |e| e.id.safe_downcase == id.safe_downcase }.id
      end

      def base_id(base_path)
        parts = base_path.split(".")
        parts[-1]
      end
    end
  end
end
