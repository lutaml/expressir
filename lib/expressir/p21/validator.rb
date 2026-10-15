# frozen_string_literal: true

module Expressir
  module P21
    # Validates a {Population} against a loaded schema
    # (TODO.eengine/06 step 2). Single-schema scope: instance keywords
    # must be declared in the given schema; USE/REFERENCE visibility is
    # a later ladder step.
    #
    # Mapping follows ISO 10303-21 clause 12: derived attributes are
    # not mapped (a supertype attribute redeclared as DERIVED keeps its
    # slot, valued `*`), inverse attributes are not mapped, and the
    # value order is supertype attributes first.
    module Validator
      Note = Struct.new(:id, :severity, :instance, :message, keyword_init: true)

      module_function

      # `short_names` maps exchange-structure short names (ISO 10303-21,
      # clause 12.3) to schema entity names, e.g. {"CPT" => "cartesian_point"}.
      def validate(population, schema, short_names: nil)
        short_names = short_names&.transform_keys(&:downcase)
        notes = []
        check_file_schema(notes, population, schema)
        population.instances.each do |id, instance|
          if instance.is_a?(ComplexRecord)
            check_complex(notes, schema, population, id, instance, short_names)
          else
            check_simple(notes, schema, population, id, instance, short_names)
          end
        end
        notes
      end

      def errors(notes)
        notes.select { |note| note.severity == :error }
      end

      def warnings(notes)
        notes.select { |note| note.severity == :warning }
      end

      def valid?(notes)
        errors(notes).empty?
      end

      def note!(notes, id, severity, instance, message)
        notes << Note.new(id: id, severity: severity, instance: instance,
                          message: message)
      end

      def check_file_schema(notes, population, schema)
        declared = Array(population.header["FILE_SCHEMA"]).flatten.first
        return unless declared && schema.id
        return if declared.downcase == schema.id.downcase

        note!(notes, :p21_schema_mismatch, :warning, nil,
              "FILE_SCHEMA '#{declared}' does not match schema '#{schema.id}'")
      end

      def check_simple(notes, schema, population, id, record, short_names)
        entity = find_entity(schema, record.keyword, short_names)
        unless entity
          note!(notes, :p21_unknown_entity, :error, id,
                "#{record.keyword} is not declared in schema '#{schema.id}'")
          return
        end

        check_params(notes, schema, population, id, record.params,
                     mapped_slots(entity))
      end

      def check_complex(notes, schema, population, id, complex, short_names)
        pairs = complex.records.filter_map do |record|
          entity = find_entity(schema, record.keyword, short_names)
          unless entity
            note!(notes, :p21_unknown_entity, :error, id,
                  "#{record.keyword} is not declared in schema '#{schema.id}'")
            next nil
          end

          [record, entity]
        end
        return if pairs.empty?

        check_clique(notes, id, pairs.map { |_, entity| entity })
        pairs.each do |record, entity|
          slots = explicit_attributes(entity).map { |attr| [attr, false] }
          check_params(notes, schema, population, id, record.params, slots)
        end
      end

      # A complex instance's records must form a valid supertype graph
      # path: they share at least one common supertype.
      def check_clique(notes, id, entities)
        common = closure_keys(entities.first)
        entities.drop(1).each { |entity| common &= closure_keys(entity) }
        return unless common.empty?

        note!(notes, :p21_complex_clique, :error, id,
              "#{id}: complex records share no common supertype")
      end

      def closure_keys(entity)
        keys = entity.supertype_closure.filter_map { |e| e.id&.downcase }
        keys << entity.id&.downcase
      end

      # Part 21 value order: supertype attributes first; an attribute
      # redeclared as DERIVED in the entity keeps its inherited slot,
      # valued `*` (12.2.6).
      def mapped_slots(entity)
        own_derived_keys = own_derived_attributes(entity)
          .filter_map { |attr| attr.id&.downcase }
        inherited = entity.supertype_closure.flat_map do |supertype|
          explicit_attributes(supertype)
        end
        inherited.map do |attr|
          [attr, own_derived_keys.include?(attr.id&.downcase)]
        end + explicit_attributes(entity).map { |attr| [attr, false] }
      end

      def check_params(notes, schema, population, id, params, slots)
        if params.size != slots.size
          note!(notes, :p21_arity_mismatch, :error, id,
                "#{id}: #{params.size} values for #{slots.size} mapped attributes")
        end

        slots.zip(params).each do |(attr, derived_slot), value|
          next if value.nil?

          if derived_slot
            next if value == :derived

            note!(notes, :p21_derived_slot, :error, id,
                  "#{id}: attribute '#{attr.id}' redeclared DERIVED must be '*'")
            next
          end

          check_value(notes, schema, population, id, attr, value)
        end
      end

      def check_value(notes, schema, population, id, attr, value)
        case value
        when String
          return unless value.match?(/\A#\d+\z/)

          return if population.instances.key?(value)

          note!(notes, :p21_unknown_reference, :error, id,
                "#{id}: reference #{value} has no instance")
        when :derived
          note!(notes, :p21_derived_value, :error, id,
                "#{id}: '*' outside a derived slot")
        when TypedValue
          return if find_entity(schema, value.keyword) || find_type(schema, value.keyword)

          note!(notes, :p21_unknown_typed_keyword, :error, id,
                "#{id}: typed parameter '#{value.keyword}' does not resolve")
        when Enumeration
          items = enumeration_items(schema, attr)
          return unless items

          names = items.filter_map { |item| item.id&.downcase }
          return if names.include?(value.name.downcase)

          note!(notes, :p21_enum_value, :error, id,
                "#{id}: .#{value.name}. is not in attribute '#{attr.id}' enumeration")
        when Array
          value.each { |item| check_value(notes, schema, population, id, attr, item) }
        end
      end

      def explicit_attributes(entity)
        Array(entity.attributes)
          .select { |attr| attr.instance_of?(Model::Declarations::Attribute) }
      end

      def own_derived_attributes(entity)
        Array(entity.attributes)
          .select { |attr| attr.instance_of?(Model::Declarations::DerivedAttribute) }
      end

      def find_entity(schema, keyword, short_names = nil)
        key = keyword.downcase
        Array(schema.entities).find { |entity| entity.id&.downcase == key } ||
          resolve_short_name(schema, key, short_names)
      end

      def resolve_short_name(schema, key, short_names)
        return nil unless short_names.is_a?(Hash) && short_names[key]

        find_entity(schema, short_names[key], nil)
      end

      def find_type(schema, keyword)
        Array(schema.types).find { |type| type.id&.downcase == keyword.downcase }
      end

      def enumeration_items(schema, attr)
        type = attr&.type
        return Array(type.items) if type.is_a?(Model::DataTypes::Enumeration)

        return nil unless type.is_a?(Model::References::SimpleReference)

        declaration = find_type(schema, type.id.to_s)
        underlying = declaration&.underlying_type
        underlying.is_a?(Model::DataTypes::Enumeration) ? Array(underlying.items) : nil
      end
    end
  end
end
