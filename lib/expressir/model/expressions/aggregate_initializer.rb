module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.9 Aggregate initializer
      class AggregateInitializer < Expression
        model_attr_accessor :items, 'Array<AggregateInitializerItem>'

        # @param [Hash] options
        # @option options [Array<AggregateInitializerItem>] :items
        def initialize(options = {})
          @items = options[:items] || []

          super
        end
      end
    end
  end
end