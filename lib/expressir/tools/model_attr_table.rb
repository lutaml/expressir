# frozen_string_literal: true

require "expressir"
require "json"

# The generated class→attrs oracle for expressir#634: every class under
# Expressir::Model and its declared lutaml-model attributes, dumped
# deterministically so the rs side can be gated against it (the
# checker_attr_table.json pattern, formalized — this table IS the
# inventory of the shared wire contract).
module Expressir
  module Tools
    module ModelAttrTable
      MODEL_ROOT = File.expand_path("../model", __dir__).freeze

      module_function

      def model_classes
        # Eager-load every model file so the constants exist, then walk
        # the namespace deterministically (ObjectSpace order is
        # unspecified and machine-dependent).
        Dir[File.join(MODEL_ROOT, "**", "*.rb")].each { |f| require f }
        classes = ObjectSpace.each_object(Class).select do |k|
          k.name&.start_with?("Expressir::Model::")
        end
        classes.sort_by(&:name)
      end

      def attr_entry(attr)
        {
          "type" => type_name(attr),
          "collection" => attr.collection?,
        }
      end

      def type_name(attr)
        t = attr.type
        t.is_a?(Class) ? t.name : "native:#{t.class.name.split('::').last.downcase}"
      end

      def generate
        base = Expressir::Model::ModelElement
        serializable = Lutaml::Model::Serializable
        # The wire classes: ModelElement's tree plus lutaml-serializable
        # helpers that ride the wire (RemarkInfo). Support classes
        # (indexes, validators, resolvers) are not wire contracts.
        model_classes.select { |k| k <= base || k <= serializable }
          .each_with_object({}) do |klass, table|
            attrs = klass.attributes.keys.sort.to_h do |name|
              [name.to_s, attr_entry(klass.attributes[name])]
            end
            table[klass.name] = attrs
          end
      end

      def write(path)
        File.write(path, "#{JSON.pretty_generate(generate)}\n")
      end
    end
  end
end
