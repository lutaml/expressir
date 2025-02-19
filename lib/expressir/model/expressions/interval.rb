module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.2.4 Interval expressions
      class Interval < Expression
        LESS_THAN = "LESS_THAN"
        LESS_THAN_OR_EQUAL = "LESS_THAN_OR_EQUAL"

        attribute :low, Expression
        attribute :operator1, :string, values: %w[LESS_THAN LESS_THAN_OR_EQUAL]
        attribute :item, ::Expressir::Model::Reference
        attribute :operator2, :string, values: %w[LESS_THAN LESS_THAN_OR_EQUAL]
        attribute :high, Expression
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "low", to: :low
          map "operator1", to: :operator1
          map "item", to: :item
          map "operator2", to: :operator2
          map "high", to: :high
        end
      end
    end
  end
end
