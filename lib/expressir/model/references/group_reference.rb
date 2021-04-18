module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.4 Group references
      class GroupReference < Reference
        model_attr_accessor :ref, 'Reference'
        model_attr_accessor :entity, 'Reference'

        # @param [Hash] options
        # @option options [Reference] :ref
        # @option options [Reference] :entity
        def initialize(options = {})
          @ref = options[:ref]
          @entity = options[:entity]

          super
        end
      end
    end
  end
end