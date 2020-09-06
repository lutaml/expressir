require "erb"

module Expressir
  module Parser
    class OwlParser
      def initialize(document, options)
        @options = options
        @document = document
        @dublin_core = options.fetch(:dublin_core, false)
      end

      def parse
        erb_template.result(binding)
      end

      def self.parse(document, options = {})
        new(document, options).parse
      end

      private

      attr_reader :document, :dublin_core

      def erb_template
        @erb_template ||= ERB.new(template)
      end

      def schema
        @schema ||= document.schemas.first
      end

      def schema_uri
        @schema_uri ||= ["http://www.reeper.org", schema.name].join("/")
      end

      def template
        @template ||= File.read(Expressir.lib_path.join("owl", "template.xml.erb"))
      end
    end
  end
end
