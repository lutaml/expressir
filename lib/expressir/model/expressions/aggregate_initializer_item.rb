module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.9 Aggregate initializer
      class AggregateInitializerItem < Expression
        attribute :expression, Expressir::Model::Expression
        attribute :repetition, Expressir::Model::Expression
      end
    end
  end
end
