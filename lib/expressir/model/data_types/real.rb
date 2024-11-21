module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.2 Real data type
      class Real < DataType
        model_attr_accessor :precision, "Expression"

        # @param [Hash] options
        # @option options [Expression] :precision
        def initialize(options = {})
          @precision = options[:precision]

          super
        end
      end
    end
  end
end
