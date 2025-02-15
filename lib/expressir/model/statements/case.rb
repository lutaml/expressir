module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.4 Case statement
      class Case < Statement
        attribute :expression, Expression
        attribute :actions, CaseAction, collection: true
        attribute :otherwise_statement, Statement
      end
    end
  end
end
