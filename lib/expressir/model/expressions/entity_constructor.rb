module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 9.2.6 Implicit declarations
      class EntityConstructor < Expression
        attribute :entity, ::Expressir::Model::Reference
        attribute :parameters, Expression, collection: true
      end
    end
  end
end
