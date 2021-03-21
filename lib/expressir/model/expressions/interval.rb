module Expressir
  module Model
    module Expressions
      class Interval < ModelElement
        model_attr_accessor :low
        model_attr_accessor :operator1
        model_attr_accessor :item
        model_attr_accessor :operator2
        model_attr_accessor :high

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