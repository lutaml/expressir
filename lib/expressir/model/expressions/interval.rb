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
      end
    end
  end
end
