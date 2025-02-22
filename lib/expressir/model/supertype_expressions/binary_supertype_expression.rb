module Expressir
  module Model
    module SupertypeExpressions
      # Specified in ISO 10303-11:2004
      # - section 9.2.5.3 ANDOR
      # - section 9.2.5.4 AND
      class BinarySupertypeExpression < SupertypeExpression
        AND = "AND"
        ANDOR = "ANDOR"

        attribute :operator, :string, values: %w[AND ANDOR]
        attribute :operand1, ::Expressir::Model::SupertypeExpression
        attribute :operand2, ::Expressir::Model::SupertypeExpression
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "operator", to: :operator
          map "operand1", to: :operand1
          map "operand2", to: :operand2
        end
      end
    end
  end
end
