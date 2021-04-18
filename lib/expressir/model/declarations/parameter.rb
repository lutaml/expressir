module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.5.3 Parameters
      class Parameter < Declaration
        include Identifier

        model_attr_accessor :var, 'Boolean'
        model_attr_accessor :type, 'DataType'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Boolean] :var
        # @option options [DataType] :type
        def initialize(options = {})
          initialize_identifier(options)

          @var = options[:var]
          @type = options[:type]

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