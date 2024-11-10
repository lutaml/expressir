module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 11 Interface specification
      class InterfaceItem < ModelElement
        model_attr_accessor :ref, 'Reference'
        model_attr_accessor :id, 'String'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Reference] :ref
        # @option options [String] :id
        def initialize(options = {})
          @ref = options[:ref]
          @id = options[:id]

          super
        end
      end
    end
  end
end