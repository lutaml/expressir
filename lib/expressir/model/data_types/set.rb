module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 8.2.4 Set data type
      class Set < DataType
        model_attr_accessor :bound1, 'Expression'
        model_attr_accessor :bound2, 'Expression'
        model_attr_accessor :base_type, 'DataType'

        # @param [Hash] options
        # @option options [Expression] :bound1
        # @option options [Expression] :bound2
        # @option options [DataType] :base_type
        def initialize(options = {})
          @bound1 = options[:bound1]
          @bound2 = options[:bound2]
          @base_type = options[:base_type]

          super
        end
      end
    end
  end
end