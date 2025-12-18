require_relative "formatter"

module Expressir
  module Express
    # Pretty formatter for EXPRESS schemas following ELF specification
    # @see https://www.express-language-foundation.org/pretty-print-spec/
    class PrettyFormatter < Formatter
      # Configuration class for MECE parameter management
      # Follows the hierarchy: Options > ENV > Defaults
      class Configuration
        attr_accessor :indent, :line_length, :insert_newline, :insert_space
        attr_accessor :provenance_enabled, :provenance_name, :provenance_version

        # Initialize configuration with options, environment variables, or defaults
        # @param options [Hash] Configuration options
        def initialize(options = {})
          @indent = resolve_param(options, :indent, "EXPRESSIR_INDENT", 4)
          @line_length = resolve_param(options, :line_length, "EXPRESSIR_LINE_LENGTH", nil)
          @insert_newline = resolve_param(options, :insert_newline, "EXPRESSIR_INSERT_NEWLINE", true)
          @insert_space = resolve_param(options, :insert_space, "EXPRESSIR_INSERT_SPACE", true)
          @provenance_enabled = resolve_param(options, :provenance, "EXPRESSIR_PROVENANCE", true)
          @provenance_name = resolve_param(options, :provenance_name, "EXPRESSIR_PROVENANCE_NAME", "Expressir")
          @provenance_version = resolve_param(options, :provenance_version, "EXPRESSIR_PROVENANCE_VERSION", Expressir::VERSION)
        end

        private

        # Resolve parameter value following MECE hierarchy: Options > ENV > Defaults
        # @param options [Hash] Options hash
        # @param key [Symbol] Option key
        # @param env_key [String] Environment variable key
        # @param default [Object] Default value
        # @return [Object] Resolved value
        def resolve_param(options, key, env_key, default)
          return options[key] if options.key?(key)

          env_value = ENV[env_key]
          return parse_env_value(env_value) unless env_value.nil?

          default
        end

        # Parse environment variable value to appropriate type
        # @param value [String] Environment variable value
        # @return [Object] Parsed value
        def parse_env_value(value)
          return nil if value.nil? || value.empty?
          return true if value.downcase == "true"
          return false if value.downcase == "false"
          return value.to_i if value =~ /^\d+$/

          value
        end
      end

      attr_reader :config

      # Initialize PrettyFormatter with options
      # @param options [Hash] Formatting options
      # @option options [Integer] :indent Number of spaces per indentation level (default: 4)
      # @option options [Integer, nil] :line_length Maximum line length (default: nil)
      # @option options [Boolean] :insert_newline Insert newlines for readability (default: true)
      # @option options [Boolean] :insert_space Insert spaces for readability (default: true)
      # @option options [Boolean] :provenance Include provenance information (default: true)
      # @option options [String] :provenance_name Tool name for provenance (default: "Expressir")
      # @option options [String] :provenance_version Tool version for provenance (default: Expressir::VERSION)
      # @option options [Boolean] :no_remarks Suppress remarks in output (default: false)
      def initialize(options = {})
        @config = Configuration.new(options)
        super(no_remarks: options.fetch(:no_remarks, false))
      end

      private

      # Override indent to use configured width
      # @param str [String] String to indent
      # @return [String] Indented string
      def indent(str)
        return if str.nil?

        indent_str = " " * @config.indent
        str.split("\n").map { |x| "#{indent_str}#{x}" }.join("\n")
      end

      # Format inline tail remark
      # @param node [Model::ModelElement] Node with potential tail remark
      # @return [String] Tail remark or empty string
      def format_inline_tail_remark(node)
        return "" if @no_remarks
        return "" unless node.respond_to?(:untagged_remarks)
        return "" if node.untagged_remarks.nil? || node.untagged_remarks.empty?

        # Get first untagged remark
        remark = node.untagged_remarks.first
        return "" if remark.nil?

        # Handle both RemarkInfo and String
        if remark.is_a?(Model::RemarkInfo)
          text = remark.text
          return "" if text.nil? || text.empty?

          # Include tag if present
          formatted_text = remark.tagged? ? "\"#{remark.tag}\" #{text}" : text

          # Use format from RemarkInfo
          remark.tail? ? " -- #{formatted_text}" : " (* #{formatted_text} *)"
        else
          # Legacy string - default to tail format
          return "" if remark.empty?
          " -- #{remark}"
        end
      end

      # Override to preserve tail remarks on attributes
      # @param node [Model::Declarations::Entity] Entity node
      # @return [String] Formatted entity
      def format_declarations_entity(node)
        if node.attributes.nil?
          explicit_attributes = []
          derived_attributes = []
          inverse_attributes = []
        else
          explicit_attributes = node.attributes.select do |x|
            x.kind == Model::Declarations::Attribute::EXPLICIT
          end
          derived_attributes = node.attributes.select do |x|
            x.kind == Model::Declarations::Attribute::DERIVED
          end
          inverse_attributes = node.attributes.select do |x|
            x.kind == Model::Declarations::Attribute::INVERSE
          end
        end

        indent_str = " " * @config.indent
        preamble = format_preamble_remarks(node, indent_str)

        [
          [
            "ENTITY",
            " ",
            node.id,
            *if node.abstract && !node.supertype_expression
               [
                 "\n",
                 indent([
                   "ABSTRACT",
                   " ",
                   "SUPERTYPE",
                 ].join),
               ].join
             end,
            *if node.abstract && node.supertype_expression
               [
                 "\n",
                 indent([
                   "ABSTRACT",
                   " ",
                   "SUPERTYPE",
                   " ",
                   "OF",
                   " ",
                   "(",
                   format(node.supertype_expression),
                   ")",
                 ].join),
               ].join
             end,
            *if !node.abstract && node.supertype_expression
               [
                 "\n",
                 indent([
                   "SUPERTYPE",
                   " ",
                   "OF",
                   " ",
                   "(",
                   format(node.supertype_expression),
                   ")",
                 ].join),
               ].join
             end,
            *if node.subtype_of&.length&.positive?
               [
                 "\n",
                 indent([
                   "SUBTYPE",
                   " ",
                   "OF",
                   " ",
                   "(",
                   node.subtype_of.map { |x| format(x) }.join(", "),
                   ")",
                 ].join),
               ].join
             end,
            ";",
          ].join,
          *if preamble && !preamble.empty?
             preamble.rstrip
           end,
          *if explicit_attributes&.length&.positive?
             indent(explicit_attributes.map { |x| format(x) }.join("\n"))
           end,
          *if derived_attributes&.length&.positive?
             [
               "DERIVE",
               indent(derived_attributes.map { |x| format(x) }.join("\n")),
             ]
           end,
          *if inverse_attributes&.length&.positive?
             [
               "INVERSE",
               indent(inverse_attributes.map { |x| format(x) }.join("\n")),
             ]
           end,
          *if node.unique_rules&.length&.positive?
             [
               "UNIQUE",
               indent(node.unique_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          *if node.where_rules&.length&.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_ENTITY",
            ";",
            format_end_scope_remark(node),
          ].join,
        ].join("\n")
      end

      # Format preamble remarks before SCHEMA
      # @param source_remarks [Array<String>] Source remarks
      # @return [Array<String>] Formatted preamble lines
      def format_preamble(source_remarks)
        return [] if source_remarks.nil? || source_remarks.empty?

        preamble = source_remarks.map { |remark| format_preamble_remark(remark) }
        preamble << "" # Blank line after preamble
        preamble
      end

      # Format a single preamble remark
      # @param remark [String, RemarkInfo] Remark text or RemarkInfo object
      # @param indent_str [String] Indentation to use (optional)
      # @return [String] Formatted remark
      def format_preamble_remark(remark, indent_str = "")
        # Handle both String (legacy) and RemarkInfo
        if remark.is_a?(Model::RemarkInfo)
          text = remark.text

          # Include tag if present
          text = "\"#{remark.tag}\" #{text}" if remark.tagged?

          # Use format from RemarkInfo
          if remark.tail?
            "-- #{text}"
          else
            # Embedded remark - always use embedded format for preamble
            text.include?("\n") ? ["(*", text, "*)"].join("\n") : "(* #{text} *)"
          end
        else
          # Legacy string handling
          remark.include?("\n") ? ["(*", remark, "*)"].join("\n") : "(* #{remark} *)"
        end
      end

      # Generate provenance remark
      # @return [String, nil] Provenance comment or nil if disabled
      def format_provenance
        return nil unless @config.provenance_enabled

        params = []
        params << "indent: #{@config.indent}"
        params << "line_length: #{@config.line_length}" if @config.line_length

        [
          "(*",
          "  Generated by: #{@config.provenance_name} version #{@config.provenance_version}",
          "  Format parameters: #{params.join(', ')}",
          "*)"
        ].join("\n")
      end

      # Override to add preamble and provenance
      # @param node [Model::Repository] Repository node
      # @return [String] Formatted repository
      def format_repository(node)
        result = []

        # Add preamble if source has remarks
        if node.respond_to?(:source_remarks)
          result.concat(format_preamble(node.source_remarks))
        end

        # Add provenance
        provenance = format_provenance
        result << provenance if provenance
        result << "" if provenance

        # Add schemas
        schemas = node.schemas&.map { |x| format(x) }&.join("\n\n")
        result << schemas if schemas

        result.join("\n") + "\n"
      end

      # Format a block of constants with aligned colons and assignments
      # @param constants [Array<Model::Declarations::Constant>] Constants to format
      # @return [String] Formatted constants with alignment
      def format_constant_block(constants)
        return "" if constants.nil? || constants.empty?

        # Calculate alignment positions
        max_name_len = constants.map { |c| c.id.length }.max
        type_strings = constants.map { |c| format(c.type) }
        max_type_len = type_strings.map(&:length).max

        # Format each constant with alignment
        formatted = constants.zip(type_strings).map do |constant, type_str|
          name_padding = " " * (max_name_len - constant.id.length)
          type_padding = " " * (max_type_len - type_str.length)

          "#{constant.id}#{name_padding} : #{type_str}#{type_padding} := #{format(constant.expression)};"
        end

        formatted.join("\n")
      end

      # Override format_declarations_schema to use aligned constants
      # @param node [Model::Declarations::Schema] Schema node
      # @return [String] Formatted schema
      def format_declarations_schema(node)
        indent_str = " " * @config.indent
        preamble = format_preamble_remarks(node, indent_str)

        schema_declarations = [
          *if node.constants&.length&.positive?
             [
               "CONSTANT",
               indent(format_constant_block(node.constants)),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n")
           end,
          *if node.types&.length&.positive?
             node.types.map { |x| format(x) }
           end,
          *if node.entities&.length&.positive?
             node.entities.map { |x| format(x) }
           end,
          *if node.subtype_constraints&.length&.positive?
             node.subtype_constraints.map { |x| format(x) }
           end,
          *if node.functions&.length&.positive?
             node.functions.map { |x| format(x) }
           end,
          *if node.rules&.length&.positive?
             node.rules.map { |x| format(x) }
           end,
          *if node.procedures&.length&.positive?
             node.procedures.map { |x| format(x) }
           end,
        ]

        [
          format_declarations_schema_head(node),
          *if preamble && !preamble.empty?
             [
               "",
               preamble.rstrip,
             ]
           end,
          *if schema_declarations&.length&.positive?
             [
               "",
               schema_declarations.join("\n\n"),
               "",
             ]
           end,
          [
            "END_SCHEMA",
            ";",
            format_end_scope_remark(node),
          ].join,
        ].join("\n")
      end

      # Override format_declarations_function to use aligned constants
      # @param node [Model::Declarations::Function] Function node
      # @return [String] Formatted function
      def format_declarations_function(node)
        [
          [
            "FUNCTION",
            " ",
            node.id,
            *if node.parameters&.length&.positive?
               parameter_indent = " " * "FUNCTION #{node.id}(".length
               [
                 "(",
                 node.parameters.map do |x|
                   format(x)
                 end.join(";\n#{parameter_indent}"),
                 ")",
               ].join
             end,
            " ",
            ":",
            " ",
            format(node.return_type),
            ";",
          ].join,
          *if node.types&.length&.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities&.length&.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints&.length&.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions&.length&.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures&.length&.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants&.length&.positive?
             indent([
               "CONSTANT",
               indent(format_constant_block(node.constants)),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.variables&.length&.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.statements&.length&.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          [
            "END_FUNCTION",
            ";",
            format_end_scope_remark(node),
          ].join,
        ].join("\n")
      end

      # Override format_declarations_procedure to use aligned constants
      # @param node [Model::Declarations::Procedure] Procedure node
      # @return [String] Formatted procedure
      def format_declarations_procedure(node)
        [
          [
            "PROCEDURE",
            " ",
            node.id,
            *if node.parameters&.length&.positive?
               parameter_indent = " " * "PROCEDURE #{node.id}(".length
               [
                 "(",
                 node.parameters.map do |x|
                   format(x)
                 end.join(";\n#{parameter_indent}"),
                 ")",
               ].join
             end,
            ";",
          ].join,
          *if node.types&.length&.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities&.length&.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints&.length&.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions&.length&.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures&.length&.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants&.length&.positive?
             indent([
               "CONSTANT",
               indent(format_constant_block(node.constants)),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.variables&.length&.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.statements&.length&.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          [
            "END_PROCEDURE",
            ";",
            format_end_scope_remark(node),
          ].join,
        ].join("\n")
      end

      # Override format_declarations_rule to use aligned constants
      # @param node [Model::Declarations::Rule] Rule node
      # @return [String] Formatted rule
      def format_declarations_rule(node)
        node.applies_to ||= []
        [
          [
            "RULE",
            " ",
            node.id,
            " ",
            "FOR",
            " ",
            "(",
            node.applies_to.map { |x| format(x) }.join(", "),
            ")",
            ";",
          ].join,
          *if node.types&.length&.positive?
             indent(node.types.map { |x| format(x) }.join("\n"))
           end,
          *if node.entities&.length&.positive?
             indent(node.entities.map { |x| format(x) }.join("\n"))
           end,
          *if node.subtype_constraints&.length&.positive?
             indent(node.subtype_constraints.map { |x| format(x) }.join("\n"))
           end,
          *if node.functions&.length&.positive?
             indent(node.functions.map { |x| format(x) }.join("\n"))
           end,
          *if node.procedures&.length&.positive?
             indent(node.procedures.map { |x| format(x) }.join("\n"))
           end,
          *if node.constants&.length&.positive?
             indent([
               "CONSTANT",
               indent(format_constant_block(node.constants)),
               [
                 "END_CONSTANT",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.variables&.length&.positive?
             indent([
               "LOCAL",
               indent(node.variables.map { |x| format(x) }.join("\n")),
               [
                 "END_LOCAL",
                 ";",
               ].join,
             ].join("\n"))
           end,
          *if node.statements&.length&.positive?
             indent(node.statements.map { |x| format(x) }.join("\n"))
           end,
          *if node.where_rules&.length&.positive?
             [
               "WHERE",
               indent(node.where_rules.map { |x| format(x) }.join("\n")),
             ]
           end,
          [
            "END_RULE",
            ";",
          ].join,
        ].join("\n")
      end
    end
  end
end