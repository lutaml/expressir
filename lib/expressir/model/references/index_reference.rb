module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.3.1 Binary indexing
      # - section 12.5.1 String indexing
      # - section 12.6.1 Aggregate indexing
      class IndexReference < Reference
        model_attr_accessor :ref, 'Reference'
        model_attr_accessor :index1, 'Expression'
        model_attr_accessor :index2, 'Expression'

        # @param [Hash] options
        # @option options [Reference] :ref
        # @option options [Expression] :index1
        # @option options [Expression] :index2
        def initialize(options = {})
          @ref = options[:ref]
          @index1 = options[:index1]
          @index2 = options[:index2]

          super
        end
      end
    end
  end
end