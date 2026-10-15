# frozen_string_literal: true

module Expressir
  module P21
    # Turns a {Grammar} capture tree into a {Population}.
    module Builder
      module_function

      def build(tree)
        header = build_header(tree[:header_section])
        instances = build_instances(tree[:data_section])
        Population.new(header: header, instances: instances)
      end

      def build_header(section)
        Array(section[:header_entity]).each_with_object({}) do |entry, hash|
          record = entry[:simple_record]
          hash[record_keyword(record)] = record_params(record)
        end
      end

      def build_instances(section)
        list = section[:instance_list]
        entries = list.is_a?(Array) ? list : [list]
        entries.each_with_object({}) do |entry, hash|
          if (complex = entry[:complex_entity_instance])
            hash[instance_id(complex)] = build_complex(complex)
          elsif (simple = entry[:simple_entity_instance])
            record = simple[:simple_record]
            hash[instance_id(simple)] = Record.new(record_keyword(record),
                                                   record_params(record))
          end
        end
      end

      def instance_id(body)
        "##{body[:entity_instance_name].to_s.delete_prefix('#')}"
      end

      def build_complex(body)
        subs = body[:subsuper_record]
        subs = [subs] unless subs.is_a?(Array)
        records = subs.map do |sub|
          record = sub[:simple_record]
          Record.new(record_keyword(record), record_params(record))
        end
        ComplexRecord.new(records)
      end

      def record_keyword(record)
        record[:keyword].to_s.delete_prefix("!")
      end

      # A parameter_list capture is a hash when there is a single parameter
      # and an array of {parameter: ...} entries otherwise.
      def parameter_list_values(capture)
        return [] if capture.nil?

        entries = capture.is_a?(Array) ? capture : [capture]
        entries.map { |entry| build_value(entry[:parameter]) }
      end

      def record_params(record)
        parameter_list_values(record[:parameter_list])
      end

      def build_value(param)
        if (typed = param[:typed_parameter])
          TypedValue.new(typed[:keyword].to_s.delete_prefix("!"),
                         parameter_list_values(typed[:parameter_list]))
        elsif param[:parameter_list]
          parameter_list_values(param[:parameter_list])
        elsif param[:entity_instance_name]
          "##{param[:entity_instance_name].to_s.delete_prefix('#')}"
        elsif param[:number_literal]
          text = param[:number_literal].to_s
          text.match?(/[.Ee]/) ? text.to_f : text.to_i
        elsif param[:enumeration]
          Enumeration.new(param[:enumeration].to_s.delete_prefix(".").delete_suffix("."))
        elsif param[:binary_literal]
          Binary.new(param[:binary_literal].to_s.delete_prefix('"').delete_suffix('"'))
        elsif param[:string_literal]
          param[:string_literal].to_s[1..-2].gsub("''", "'")
        elsif param[:unset]
          :unset
        elsif param[:derived]
          :derived
        end
      end
    end
  end
end
