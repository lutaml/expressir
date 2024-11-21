module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.4.1 Enumeration data type
      class EnumerationItem < ModelElement
        include Identifier

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        def initialize(options = {})
          initialize_identifier(options)

          super
        end

        # @return [Array<Declaration>]
        def children
          [
            *remark_items,
          ]
        end
      end
    end
  end
end
