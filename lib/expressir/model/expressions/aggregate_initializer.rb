module Expressir
  module Model
    module Expressions
      class AggregateInitializer < ModelElement
        attr_accessor :items

        def initialize(options = {})
          @items = options.fetch(:items, [])

          super
        end
      end
    end
  end
end