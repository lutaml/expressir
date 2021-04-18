module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.5 Logical literal
      class Logical < Literal
        TRUE = :TRUE
        FALSE = :FALSE
        UNKNOWN = :UNKNOWN

        model_attr_accessor :value, ':TRUE, :FALSE, :UNKNOWN'

        # @param [Hash] options
        # @option options [:TRUE, :FALSE, :UNKNOWN] :value
        def initialize(options = {})
          @value = options[:value]

          super
        end
      end
    end
  end
end