module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.2.4 Interval expressions
      class Interval < Expression
        LESS_THAN = :LESS_THAN
        LESS_THAN_OR_EQUAL = :LESS_THAN_OR_EQUAL

        model_attr_accessor :low, "Expression"
        model_attr_accessor :operator1, ":LESS_THAN, :LESS_THAN_OR_EQUAL"
        model_attr_accessor :item, "Reference"
        model_attr_accessor :operator2, ":LESS_THAN, :LESS_THAN_OR_EQUAL"
        model_attr_accessor :high, "Expression"

        # @param [Hash] options
        # @option options [Expression] :low
        # @option options [:LESS_THAN, :LESS_THAN_OR_EQUAL] :operator1
        # @option options [Reference] :item
        # @option options [:LESS_THAN, :LESS_THAN_OR_EQUAL] :operator2
        # @option options [Expression] :high
        def initialize(options = {})
          @low = options[:low]
          @operator1 = options[:operator1]
          @item = options[:item]
          @operator2 = options[:operator2]
          @high = options[:high]

          super
        end
      end
    end
  end
end
