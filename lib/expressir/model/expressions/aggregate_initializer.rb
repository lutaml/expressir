module Expressir
  module Model
    module Expressions
      class AggregateInitializer
        attr_accessor :items

        def initialize(options = {})
          @items = options[:items]
        end
      end
    end
  end
end