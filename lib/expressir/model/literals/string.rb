module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.4 String literal
      class String < Literal
        model_attr_accessor :value, '::String'
        model_attr_accessor :encoded, '::Boolean'

        # @param [Hash] options
        # @option options [::String] :value
        # @option options [::Boolean] :encoded
        def initialize(options = {})
          @value = options[:value]
          @encoded = options[:encoded]

          super
        end
      end
    end
  end
end