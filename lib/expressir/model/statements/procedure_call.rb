module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.8 Procedure call statement
      class ProcedureCall < Statement
        attribute :procedure, ::Expressir::Model::Reference
        attribute :parameters, Expression, collection: true
      end
    end
  end
end
