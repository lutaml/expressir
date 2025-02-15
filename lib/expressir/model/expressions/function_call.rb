module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.8 Function call
      class FunctionCall < Expression
        attribute :function, ::Expressir::Model::Reference
        attribute :parameters, Expression, collection: true
      end
    end
  end
end
