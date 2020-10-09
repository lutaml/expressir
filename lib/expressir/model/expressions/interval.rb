module Expressir
    module Model
      module Expressions
        class Interval
          attr_accessor :low
          attr_accessor :operator1
          attr_accessor :item
          attr_accessor :operator2
          attr_accessor :high
  
          def initialize(options = {})
            @low = options[:low]
            @operator1 = options[:operator1]
            @item = options[:item]
            @operator2 = options[:operator2]
            @high = options[:high]
          end
        end
      end
    end
  end