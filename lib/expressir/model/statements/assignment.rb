module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.3 Assignment
      class Assignment < Statement
        attribute :ref, ::Expressir::Model::Reference
        attribute :expression, Expressir::Model::Expression
      end
    end
  end
end
