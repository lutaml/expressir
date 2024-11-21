module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.3 Real literal
      class Real < Literal
        model_attr_accessor :value, "::String"

        # @param [Hash] options
        # @option options [::String] :value
        def initialize(options = {})
          @value = options[:value]

          super
        end
      end
    end
  end
end
