# frozen_string_literal: true

module Expressir
  module Commands
    # `expressir mapping validate` (#88): load a module mapping.yaml
    # and resolve every <<express:...>> link against the ARM/MIM
    # interface closure. Exits 1 when unknown links remain.
    class MappingValidate < Base
      def run(path)
        document = Expressir::Mapping.load_file(path)
        unknown = Expressir::Mapping.unknown_links(document, repository_for(path))

        if unknown.empty?
          say "all links resolve"
          return
        end

        unknown.each do |link|
          say "unknown: #{link.text}"
        end
        raise Thor::Error, "#{unknown.size} unknown link(s)"
      end

      private

      def repository_for(path)
        dir = File.dirname(File.expand_path(path))
        arm = Dir[File.join(dir, "arm.exp")].first
        mim = Dir[File.join(dir, "mim.exp")].first
        roots = [arm, mim].compact
        raise Thor::Error, "no arm.exp/mim.exp next to #{path}" if roots.empty?

        files = roots.flat_map do |root|
          ParityInputs.closure_paths(root)
        end.uniq.select { |f| File.exist?(f) }
        Expressir::Express::Parser.from_files(files)
      end
    end
  end
end
