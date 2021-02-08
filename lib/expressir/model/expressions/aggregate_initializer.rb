module Expressir
  module Model
    module Expressions
      class AggregateInitializer < ModelElement
        attr_accessor :items

        def initialize(options = {})
          @items = options.fetch(:items, [])
        end
      end
    end
  end
end