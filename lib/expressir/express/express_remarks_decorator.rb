module Expressir
  module Express
    class ExpressRemarksDecorator
      RELATIVE_PREFIX_MACRO_REGEXP = /^(link|image|video|audio|include)(:+)?(?![^\/:]+:\/\/|[A-Z]:\/|\/)([^:\[]+)(\[.*\])?$/.freeze

      attr_reader :remark, :options

      def self.call(remark, options)
        new(remark, options).call
      end

      def initialize(remark, options)
        @remark = remark
        @options = options
      end

      def call
        result = remark
        if options["relative_path_prefix"]
          result = update_relative_paths(result,
                                         options["relative_path_prefix"])
        end
        result
      end

      private

      def update_relative_paths(string, path_prefix)
        string
          .split("\n")
          .map do |line|
            if line.match?(RELATIVE_PREFIX_MACRO_REGEXP)
              prefix_relative_paths(line, path_prefix)
            else
              line
            end
          end
          .join("\n")
      end

      def prefix_relative_paths(line, path_prefix)
        line.gsub(RELATIVE_PREFIX_MACRO_REGEXP) do |_match|
          prefixed_path = File.join(path_prefix, $3.strip)
          # When we are dealing with a relative path of a template:
          # ../path/to/file we need to transform it into
          # the absolute one because `image::` macro wont understand it other way
          prefixed_path = File.absolute_path(prefixed_path) if prefixed_path.start_with?("../")
          full_path = File.expand_path(prefixed_path)
          "#{$1}#{$2}#{full_path}#{$4}"
        end
      end
    end
  end
end
