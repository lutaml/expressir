module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.9 Aggregate initializer
      class AggregateInitializer < Expression
        attribute :items, AggregateInitializerItem, collection: true
      end
    end
  end
end
