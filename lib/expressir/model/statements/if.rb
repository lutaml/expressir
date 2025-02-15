module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.7 If ... Then ... Else statement
      class If < Statement
        attribute :expression, Expression
        attribute :statements, Statement, collection: true
        attribute :else_statements, Statement, collection: true
      end
    end
  end
end
