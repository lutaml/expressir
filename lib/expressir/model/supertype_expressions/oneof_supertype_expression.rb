module Expressir
  module Model
    module SupertypeExpressions
      # Specified in ISO 10303-11:2004
      # - section 9.2.5.2 ONEOF
      class OneofSupertypeExpression < SupertypeExpression
        attribute :operands, ::Expressir::Model::SupertypeExpression, collection: true
      end
    end
  end
end
