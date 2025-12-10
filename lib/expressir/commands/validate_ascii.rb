# frozen_string_literal: true

require "set"
require "paint"
require "table_tennis"

module Expressir
  module Commands
    # Represents a non-ASCII character with its details and replacement
    class NonAsciiCharacter
      attr_reader :char, :hex, :utf8, :is_math, :replacement,
                  :replacement_type, :occurrences

      def initialize(char, hex, utf8, is_math, replacement, replacement_type)
        @char = char
        @hex = hex
        @utf8 = utf8
        @is_math = is_math
        @replacement = replacement
        @replacement_type = replacement_type
        @occurrences = []
      end

      def add_occurrence(line_number, column, line)
        @occurrences << {
          line_number: line_number,
          column: column,
          line: line,
        }
      end

      def replacement_text
        @is_math ? "AsciiMath: #{@replacement}" : "ISO 10303-11: #{@replacement}"
      end

      def occurrence_count
        @occurrences.size
      end

      def to_h
        {
          character: @char,
          hex: @hex,
          utf8: @utf8,
          is_math: @is_math,
          replacement_type: @replacement_type,
          replacement: @replacement,
          occurrence_count: occurrence_count,
          occurrences: @occurrences,
        }
      end
    end

    # Represents all non-ASCII characters in a file
    class FileViolations
      attr_reader :path, :filename, :directory, :violations, :unique_characters

      def initialize(file_path)
        @path = file_path
        @filename = File.basename(file_path)
        @directory = File.dirname(file_path)
        @characters = {}  # Map of characters to NonAsciiCharacter objects
        @violations = []  # List of violations (line, column, etc.)
      end

      def add_violation(line_number, column, match, char_details, line)
        violation = {
          line_number: line_number,
          column: column,
          match: match,
          char_details: char_details,
          line: line,
        }

        @violations << violation

        # Register each character
        char_details.each do |detail|
          char = detail[:char]
          unless @characters[char]
            @characters[char] = NonAsciiCharacter.new(
              char,
              detail[:hex],
              detail[:utf8],
              detail[:is_math],
              detail[:replacement],
              detail[:replacement_type],
            )
          end

          @characters[char].add_occurrence(line_number, column, line)
        end
      end

      def violation_count
        @violations.size
      end

      def unique_characters
        @characters.values
      end

      def display_path
        "#{File.basename(@directory)}/#{@filename}"
      end

      def full_path
        File.expand_path(@path)
      end

      def to_h
        {
          file: display_path,
          count: violation_count,
          non_ascii_characters: unique_characters.map(&:to_h),
        }
      end
    end

    # Collection of all violations across multiple files
    class NonAsciiViolationCollection
      attr_reader :file_violations, :total_files

      def initialize(check_remarks: false)
        @file_violations = {} # Map of file paths to FileViolations objects
        @total_files = 0
        @unicode_to_asciimath = nil
        @check_remarks = check_remarks
      end

      def process_file(file)
        @total_files += 1

        # Initialize the mapping once
        @unicode_to_asciimath ||= build_unicode_to_asciimath_map

        file_violations = process_file_violations(file)
        return if file_violations.violations.empty?

        @file_violations[file] = file_violations
      end

      def files_with_violations
        @file_violations.size
      end

      def total_violations
        @file_violations.values.sum(&:violation_count)
      end

      def unique_character_count
        # Get total unique characters across all files
        all_chars = Set.new
        @file_violations.each_value do |file_violation|
          file_violation.unique_characters.each do |char|
            all_chars.add(char.char)
          end
        end
        all_chars.size
      end

      def total_occurrence_count
        # Sum all occurrences of all characters across all files
        @file_violations.values.sum do |file_violation|
          file_violation.unique_characters.sum(&:occurrence_count)
        end
      end

      def to_yaml_data
        {
          summary: {
            total_files: @total_files,
            files_with_violations: files_with_violations,
            total_violations: total_violations,
            total_unique_characters: unique_character_count,
            total_occurrences: total_occurrence_count,
          },
          violations: @file_violations.transform_keys do |k|
            File.expand_path(k)
          end.transform_values(&:to_h),
        }
      end

      def print_text_output
        # Print each file's violations if any
        unless @file_violations.empty?
          @file_violations.each_value do |file_violation|
            puts "\n#{Paint[file_violation.display_path, :cyan, :bold]}:"

            file_violation.violations.each do |v|
              puts "  #{Paint['Line',
                              :blue]} #{Paint[v[:line_number],
                                              :yellow]}, #{Paint['Column',
                                                                 :blue]} #{Paint[v[:column],
                                                                                 :yellow]}:"
              puts "    #{v[:line]}"
              puts "    #{' ' * v[:column]}#{Paint['^' * v[:match].length,
                                                   :red]} #{Paint['Non-ASCII sequence',
                                                                  :red]}"

              v[:char_details].each do |cd|
                character = file_violation.unique_characters.find do |c|
                  c.char == cd[:char]
                end
                next unless character

                puts "      #{Paint["\"#{cd[:char]}\"",
                                    :yellow]} - Hex: #{Paint[cd[:hex],
                                                             :magenta]}, UTF-8 bytes: #{Paint[cd[:utf8],
                                                                                              :magenta]}"
                puts "      #{Paint['Replacement:',
                                    :green]} #{character.replacement_text}"
              end
              puts ""
            end

            puts "  #{Paint['Found',
                            :green]} #{Paint[file_violation.violation_count,
                                             :red]} #{Paint['non-ASCII sequence(s) in',
                                                            :green]} #{Paint[file_violation.filename,
                                                                             :cyan]}\n"
          end
        end

        # Always print summary
        validation_scope = @check_remarks ? "code and remarks" : "code only (remarks excluded)"
        puts "\n#{Paint['Summary:', :blue, :bold]}"
        puts "  #{Paint['Validation scope:',
                        :green]} #{Paint[validation_scope,
                                         :cyan]}"
        puts "  #{Paint['Scanned',
                        :green]} #{Paint[@total_files,
                                         :yellow]} #{Paint['EXPRESS file(s)',
                                                           :green]}"
        puts "  #{Paint['Found',
                        :green]} #{Paint[total_violations,
                                         :red]} #{Paint['non-ASCII sequence(s) in',
                                                        :green]} #{Paint[files_with_violations,
                                                                         :red]} #{Paint['file(s)',
                                                                                        :green]}"
      end

      def print_table_output
        return if @file_violations.empty?

        # Build rows array
        rows = []
        total_occurrences = 0

        @file_violations.each_value do |file_violation|
          file_violation.unique_characters.each do |character|
            occurrence_count = character.occurrence_count
            total_occurrences += occurrence_count

            rows << {
              file: file_violation.display_path,
              symbol: "\"#{character.char}\" (#{character.hex})",
              replacement: character.replacement_text,
              occurrences: occurrence_count,
            }
          end
        end

        # Add total row
        rows << {
          file: "TOTAL",
          symbol: "#{unique_character_count} unique",
          replacement: "",
          occurrences: total_occurrences,
        }

        # Use TableTennis to render
        options = {
          title: "Non-ASCII Characters Summary",
          columns: %i[file symbol replacement occurrences],
          headers: {
            file: "File",
            symbol: "Symbol",
            replacement: "Replacement",
            occurrences: "Occurrences",
          },
          mark: ->(row) { row[:file] == "TOTAL" },
        }

        puts "\n#{TableTennis.new(rows, options)}\n"
      end

      private

      def process_file_violations(file)
        file_violations = FileViolations.new(file)

        if @check_remarks
          # Check remarks too - validate original file content
          File.readlines(file,
                         encoding: "UTF-8").each_with_index do |line, line_idx|
            line_number = line_idx + 1

            # Skip if line only contains ASCII
            next unless /[^\x00-\x7F]/.match?(line)

            # Find all non-ASCII sequences
            line.chomp.scan(/([^\x00-\x7F]+)/) do |match|
              match = match[0]
              column = line.index(match)

              # Process each character in the sequence
              char_details = match.chars.filter_map do |c|
                process_non_ascii_char(c)
              end

              # Skip if no non-ASCII characters found
              next if char_details.empty?

              file_violations.add_violation(line_number, column, match,
                                            char_details, line.chomp)
            end
          end
        else
          # Default: exclude remarks - use model-based approach
          # Parse the EXPRESS file to get the model
          repository = Expressir::Express::Parser.from_file(file)

          # Format each schema without remarks to get plain EXPRESS code
          repository.schemas.each do |schema|
            formatted_schema = schema.to_s(no_remarks: true)

            # Check the formatted schema (without remarks) for non-ASCII
            formatted_schema.lines.each_with_index do |line, line_idx|
              line_number = line_idx + 1

              # Skip if line only contains ASCII
              next unless /[^\x00-\x7F]/.match?(line)

              # Find all non-ASCII sequences
              line.chomp.scan(/([^\x00-\x7F]+)/) do |match|
                match = match[0]
                column = line.index(match)

                # Process each character in the sequence
                char_details = match.chars.filter_map do |c|
                  process_non_ascii_char(c)
                end

                # Skip if no non-ASCII characters found
                next if char_details.empty?

                file_violations.add_violation(line_number, column, match,
                                              char_details, line.chomp)
              end
            end
          end
        end

        file_violations
      rescue Expressir::Express::Error::SchemaParseFailure
        # If file can't be parsed, fall back to checking original content
        # This ensures we still catch non-ASCII even in invalid EXPRESS
        File.readlines(file,
                       encoding: "UTF-8").each_with_index do |line, line_idx|
          line_number = line_idx + 1

          # Skip if line only contains ASCII
          next unless /[^\x00-\x7F]/.match?(line)

          # Find all non-ASCII sequences
          line.chomp.scan(/([^\x00-\x7F]+)/) do |match|
            match = match[0]
            column = line.index(match)

            # Process each character in the sequence
            char_details = match.chars.filter_map do |c|
              process_non_ascii_char(c)
            end

            # Skip if no non-ASCII characters found
            next if char_details.empty?

            file_violations.add_violation(line_number, column, match,
                                          char_details, line.chomp)
          end
        end

        file_violations
      end

      def process_non_ascii_char(char)
        # Skip ASCII characters
        return nil if char.ord <= 0x7F

        code_point = char.ord
        hex = "0x#{code_point.to_s(16)}"
        utf8 = code_point.chr(Encoding::UTF_8).bytes.map do |b|
          "0x#{b.to_s(16)}"
        end.join(" ")

        # Check if it's a math symbol
        if asciimath = @unicode_to_asciimath[char]
          return {
            char: char,
            hex: hex,
            utf8: utf8,
            is_math: true,
            replacement: asciimath,
            replacement_type: "asciimath",
          }
        end

        # Not a math symbol, use ISO encoding
        {
          char: char,
          hex: hex,
          utf8: utf8,
          is_math: false,
          replacement: encode_iso_10303_11(char),
          replacement_type: "iso-10303-11",
        }
      end

      def encode_iso_10303_11(char)
        code_point = char.ord

        # Format the encoded value with double quotes
        if code_point < 0x10000
          "\"#{sprintf('%08X', code_point)}\"" # e.g., "00000041" for 'A'
        else
          # For higher code points, use all four octets
          group = (code_point >> 24) & 0xFF
          plane = (code_point >> 16) & 0xFF
          row = (code_point >> 8) & 0xFF
          cell = code_point & 0xFF

          "\"#{sprintf('%02X%02X%02X%02X', group, plane, row, cell)}\""
        end
      end

      def build_unicode_to_asciimath_map
        # Pre-defined mapping of common math symbols
        {
          # Greek letters
          "α" => "alpha",
          "β" => "beta",
          "γ" => "gamma",
          "Γ" => "Gamma",
          "δ" => "delta",
          "Δ" => "Delta",
          "ε" => "epsilon",
          "ζ" => "zeta",
          "η" => "eta",
          "θ" => "theta",
          "Θ" => "Theta",
          "ι" => "iota",
          "κ" => "kappa",
          "λ" => "lambda",
          "Λ" => "Lambda",
          "μ" => "mu",
          "ν" => "nu",
          "ξ" => "xi",
          "Ξ" => "Xi",
          "π" => "pi",
          "Π" => "Pi",
          "ρ" => "rho",
          "σ" => "sigma",
          "Σ" => "Sigma",
          "τ" => "tau",
          "υ" => "upsilon",
          "φ" => "phi",
          "Φ" => "Phi",
          "χ" => "chi",
          "ψ" => "psi",
          "Ψ" => "Psi",
          "ω" => "omega",
          "Ω" => "Omega",

          # Math operators
          "×" => "xx",
          "÷" => "div",
          "±" => "pm",
          "∓" => "mp",
          "∞" => "oo",
          "≤" => "le",
          "≥" => "ge",
          "≠" => "ne",
          "≈" => "~~",
          "≅" => "cong",
          "≡" => "equiv",
          "∈" => "in",
          "∉" => "notin",
          "⊂" => "subset",
          "⊃" => "supset",
          "∩" => "cap",
          "∪" => "cup",
          "∧" => "and",
          "∨" => "or",
          "¬" => "neg",
          "∀" => "forall",
          "∃" => "exists",
          "∄" => "nexists",
          "∇" => "grad",
          "∂" => "del",
          "∑" => "sum",
          "∏" => "prod",
          "∫" => "int",
          "∮" => "oint",
          "√" => "sqrt",
          "⊥" => "perp",
          "‖" => "norm",
          "→" => "rarr",
          "←" => "larr",
          "↔" => "harr",
          "⇒" => "rArr",
          "⇐" => "lArr",
          "⇔" => "hArr",
        }
      end
    end

    # ValidateAscii command for checking EXPRESS files for non-ASCII characters
    class ValidateAscii < Base
      def run(express_file_path) # rubocop:disable Metrics/AbcSize
        # Check if input is a manifest file
        if File.file?(express_file_path) && File.extname(express_file_path) == ".yaml"
          validate_from_manifest(express_file_path)
          return
        end

        # Original file/directory validation logic
        if File.file?(express_file_path)
          unless File.exist?(express_file_path)
            raise Errno::ENOENT, "Specified EXPRESS file " \
                                 "`#{express_file_path}` not found."
          end

          if File.extname(express_file_path) != ".exp"
            raise ArgumentError, "Specified file `#{express_file_path}` is " \
                                 "not an EXPRESS file."
          end

          exp_files = [express_file_path]
        elsif options[:recursive]
          # Support the relative path with glob pattern
          base_path = File.expand_path(express_file_path)
          exp_files = Dir.glob("#{base_path}/**/*.exp")
        else
          # Non-recursive option
          base_path = File.expand_path(express_file_path)
          exp_files = Dir.glob("#{base_path}/*.exp")
        end

        if exp_files.empty?
          raise Errno::ENOENT, "No EXPRESS files found in " \
                               "`#{express_file_path}`."
        end

        process_files(exp_files)
      end

      private

      def validate_from_manifest(manifest_path)
        unless File.exist?(manifest_path)
          say "Error: Manifest file not found: #{manifest_path}", :red
          exit 1
        end

        say "Loading manifest: #{manifest_path}..." if options[:verbose]

        # Load manifest
        manifest = Expressir::SchemaManifest.from_file(manifest_path)

        # Extract paths from manifest
        exp_files = manifest.schemas.map(&:path).reject do |p|
          p.nil? || p.empty?
        end

        if exp_files.empty?
          say "Error: No valid schema paths found in manifest", :red
          exit 1
        end

        say "Validating #{exp_files.size} schema(s) from manifest for ASCII compliance..." if options[:verbose]

        process_files(exp_files)
      end

      def process_files(exp_files)
        # Process all files and collect violations
        collection = NonAsciiViolationCollection.new(
          check_remarks: options[:check_remarks],
        )

        exp_files.each do |exp_file|
          collection.process_file(exp_file)
        end

        # Output results based on format
        if options[:yaml]
          require "yaml"
          puts collection.to_yaml_data.to_yaml
        else
          collection.print_text_output
          collection.print_table_output if collection.files_with_violations.positive?
        end
      end
    end
  end
end
