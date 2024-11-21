module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.1 Simple references
      class SimpleReference < Reference
        model_attr_accessor :id, "String"

        model_attr_accessor :base_path, "String"

        # @param [Hash] options
        # @option options [String] :id
        # @option options [String] :base_path
        def initialize(options = {})
          @id = options[:id]

          @base_path = options[:base_path]

          super
        end
      end
    end
  end
end
