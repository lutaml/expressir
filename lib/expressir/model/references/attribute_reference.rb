module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.3 Attribute references
      class AttributeReference < Reference
        model_attr_accessor :ref, 'Reference'
        model_attr_accessor :attribute, 'Reference'

        # @param [Hash] options
        # @option options [Reference] :ref
        # @option options [Reference] :attribute
        def initialize(options = {})
          @ref = options[:ref]
          @attribute = options[:attribute]

          super
        end
      end
    end
  end
end