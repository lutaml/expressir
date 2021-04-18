module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 9.5.3.1 Aggregate data type
      class Aggregate < DataType
        include Identifier

        model_attr_accessor :base_type, 'Type'

        # @param [Hash] options
        # @option (see Identifier#initialize_identifier)
        # @option options [Type] :base_type
        def initialize(options = {})
          initialize_identifier(options)

          @base_type = options[:base_type]

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