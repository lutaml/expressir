# frozen_string_literal: true

module Expressir
  module Liquid
    module Declarations
      class SchemaDrop < ::Expressir::Liquid::DeclarationDrop
        include ::Expressir::Liquid::IdentifierDrop

        def initialize(model, selected_schemas: nil, options: {}) # rubocop:disable Lint/MissingSuper
          @model = model
          @selected_schemas = selected_schemas
          @options = options
          initialize_identifier(@model)
          super(model)
        end

        def file
          @model.file
        end

        def file_basename
          File.basename(@model.file, ".exp")
        end

        def selected
          @selected_schemas&.include?(@model.id) ||
            @selected_schemas&.include?(file_basename)
        end

        def relative_path_prefix
          return nil if @options.nil? || @options["document"].nil?

          document = @options["document"]
          file_path = File.dirname(@model.file)
          docfile_directory = File.dirname(
            document.attributes["docfile"] || ".",
          )
          document
            .path_resolver
            .system_path(file_path, docfile_directory)
        end

        def remarks
          return [] unless @model.remarks

          options = @options || {}
          options["relative_path_prefix"] = relative_path_prefix

          @model.remarks.map do |remark|
            ::Expressir::Express::ExpressRemarksDecorator
              .call(remark, options)
          end
        end

        def version
          ::Expressir::Liquid::Declarations::SchemaVersionDrop.new(
            @model.version,
          )
        end

        def interfaces
          return [] unless @model.interfaces

          @model.interfaces.map do |item|
            ::Expressir::Liquid::Declarations::InterfaceDrop.new(item)
          end
        end

        def constants
          return [] unless @model.constants

          @model.constants.map do |item|
            ::Expressir::Liquid::Declarations::ConstantDrop.new(item)
          end
        end

        def types
          return [] unless @model.types

          @model.types.map do |item|
            ::Expressir::Liquid::Declarations::TypeDrop.new(item)
          end
        end

        def entities
          return [] unless @model.entities

          @model.entities.map do |item|
            ::Expressir::Liquid::Declarations::EntityDrop.new(item)
          end
        end

        def subtype_constraints
          return [] unless @model.subtype_constraints

          @model.subtype_constraints.map do |item|
            ::Expressir::Liquid::Declarations::SubtypeConstraintDrop.new(item)
          end
        end

        def functions
          return [] unless @model.functions

          @model.functions.map do |item|
            ::Expressir::Liquid::Declarations::FunctionDrop.new(item)
          end
        end

        def rules
          return [] unless @model.rules

          @model.rules.map do |item|
            ::Expressir::Liquid::Declarations::RuleDrop.new(item)
          end
        end

        def procedures
          return [] unless @model.procedures

          @model.procedures.map do |item|
            ::Expressir::Liquid::Declarations::ProcedureDrop.new(item)
          end
        end

        def formatted
          @model.to_s(no_remarks: true)
        end
      end
    end
  end
end
