module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.2.1 Uniqueness rule
      class UniqueRule < Declaration
        include Identifier

        model_attr_accessor :attributes, 'Reference'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Reference] :attributes
        def initialize(options = {})
          initialize_identifier(options)

          @attributes = options[:attributes] || []

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *remark_items
          ]
        end
      end
    end
  end
end