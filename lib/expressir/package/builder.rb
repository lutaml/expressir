# frozen_string_literal: true

require "zip"
require "time"
require_relative "metadata"

module Expressir
  module Package
    # Builds LER packages from Repository instances
    # Single responsibility: Create .ler ZIP packages
    class Builder
      # Build LER package from repository
      # @param repository [Model::Repository] Repository to package
      # @param output_path [String] Output .ler file path
      # @param options [Hash] Package options
      # @option options [String] :name Package name
      # @option options [String] :version Package version
      # @option options [String] :description Package description
      # @option options [String] :express_mode ('include_all') Bundling mode
      # @option options [String] :resolution_mode ('resolved') Resolution mode
      # @option options [String] :serialization_format ('marshal') Serialization format
      # @return [String] Path to created package
      def build(repository, output_path, options = {})
        options = normalize_options(options)
        metadata = build_metadata(repository, options)

        # Validate metadata
        validation = metadata.validate
        unless validation[:valid?]
          raise ArgumentError,
                "Invalid metadata: #{validation[:errors].join(', ')}"
        end

        # Create ZIP package
        Zip::File.open(output_path, Zip::File::CREATE) do |zip|
          add_metadata(zip, metadata)
          add_schemas(zip, repository, options)
          add_indexes(zip, repository)
          add_manifest(zip, repository)
        end

        output_path
      end

      private

      # Normalize options with defaults
      # @param options [Hash] Raw options
      # @return [Hash] Normalized options
      def normalize_options(options)
        {
          name: options[:name] || "Unnamed Package",
          version: options[:version] || "1.0.0",
          description: options[:description] || "",
          express_mode: options[:express_mode] || "include_all",
          resolution_mode: options[:resolution_mode] || "resolved",
          serialization_format: options[:serialization_format] || "marshal",
        }
      end

      # Build metadata from repository and options
      # @param repository [Model::Repository] Repository instance
      # @param options [Hash] Package options
      # @return [Metadata] Package metadata
      def build_metadata(repository, options)
        Metadata.new(
          name: options[:name],
          version: options[:version],
          description: options[:description],
          created_at: Time.now.utc.iso8601,
          created_by: "expressir",
          expressir_version: Expressir::VERSION,
          express_mode: options[:express_mode],
          resolution_mode: options[:resolution_mode],
          serialization_format: options[:serialization_format],
          files: count_files(repository),
          schemas: repository.schemas.size,
        )
      end

      # Count files in repository
      # @param repository [Model::Repository] Repository instance
      # @return [Integer] File count
      def count_files(repository)
        repository.schemas.count(&:file)
      end

      # Add metadata to package
      # @param zip [Zip::File] ZIP archive
      # @param metadata [Metadata] Package metadata
      # @return [void]
      def add_metadata(zip, metadata)
        zip.get_output_stream("metadata.yaml") do |stream|
          stream.write(metadata.to_yaml)
        end
      end

      # Add schemas to package based on resolution mode
      # @param zip [Zip::File] ZIP archive
      # @param repository [Model::Repository] Repository instance
      # @param options [Hash] Package options
      # @return [void]
      def add_schemas(zip, repository, options)
        case options[:resolution_mode]
        when "resolved"
          add_serialized_repository(zip, repository,
                                    options[:serialization_format])
        end

        # Add EXPRESS files if include_all mode
        if options[:express_mode] == "include_all"
          add_express_files(zip, repository)
        end
      end

      # Add serialized repository to package
      # @param zip [Zip::File] ZIP archive
      # @param repository [Model::Repository] Repository instance
      # @param format [String] Serialization format
      # @return [void]
      def add_serialized_repository(zip, repository, format)
        case format
        when "marshal"
          zip.get_output_stream("repository.marshal") do |stream|
            stream.write(Marshal.dump(repository))
          end
        when "json"
          zip.get_output_stream("repository.json") do |stream|
            stream.write(repository.to_json)
          end
        when "yaml"
          zip.get_output_stream("repository.yaml") do |stream|
            stream.write(repository.to_yaml)
          end
        end
      end

      # Add EXPRESS files to package
      # @param zip [Zip::File] ZIP archive
      # @param repository [Model::Repository] Repository instance
      # @return [void]
      def add_express_files(zip, repository)
        repository.schemas.each do |schema|
          next unless schema.file && File.exist?(schema.file)

          # Use schema id as filename
          filename = "express_files/#{schema.id}.exp"
          zip.get_output_stream(filename) do |stream|
            stream.write(File.read(schema.file))
          end
        end
      end

      # Add indexes to package
      # @param zip [Zip::File] ZIP archive
      # @param repository [Model::Repository] Repository instance
      # @return [void]
      def add_indexes(zip, repository)
        # Ensure indexes are built
        repository.build_indexes if repository.entity_index.nil?

        # Serialize indexes using Marshal for performance
        zip.get_output_stream("entity_index.marshal") do |stream|
          stream.write(Marshal.dump(repository.entity_index))
        end

        zip.get_output_stream("type_index.marshal") do |stream|
          stream.write(Marshal.dump(repository.type_index))
        end

        zip.get_output_stream("reference_index.marshal") do |stream|
          stream.write(Marshal.dump(repository.reference_index))
        end
      end

      # Add manifest to package with rewritten paths
      # @param zip [Zip::File] ZIP archive
      # @param repository [Model::Repository] Repository instance
      # @return [void]
      def add_manifest(zip, repository)
        # Create manifest with package-internal paths
        manifest = Expressir::SchemaManifest.new

        repository.schemas.each do |schema|
          manifest.schemas << Expressir::SchemaManifestEntry.new(
            id: schema.id,
            path: "express_files/#{schema.id}.exp", # Package-internal path
          )
        end

        # Set output_path to suppress relative path calculation
        manifest.output_path = "manifest.yaml"

        zip.get_output_stream("manifest.yaml") do |stream|
          stream.write(manifest.to_yaml)
        end
      end
    end
  end
end
