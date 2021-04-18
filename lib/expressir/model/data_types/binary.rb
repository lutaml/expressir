module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.1.7 Binary data type
      class Binary < DataType
        model_attr_accessor :width, 'Expression'
        model_attr_accessor :fixed, '::Boolean'

        # @param [Hash] options
        # @option options [Expression] :width
        # @option options [::Boolean] :fixed
        def initialize(options = {})
          @width = options[:width]
          @fixed = options[:fixed]

          super
        end
      end
    end
  end
end