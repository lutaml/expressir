module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.9 Aggregate initializer
      class AggregateInitializerItem < Expression
        attribute :expression, Expressir::Model::Expression
        attribute :repetition, Expressir::Model::Expression
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "expression", to: :expression
          map "repetition", to: :repetition
        end
      end
    end
  end
end
