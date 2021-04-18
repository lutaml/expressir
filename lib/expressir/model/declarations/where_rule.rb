module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.2.2 Domain rules (WHERE clause)
      class WhereRule < Declaration
        include Identifier

        model_attr_accessor :expression, 'Expression'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Expression] :expression
        def initialize(options = {})
          initialize_identifier(options)

          @expression = options[:expression]

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