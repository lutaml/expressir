module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.4 Case statement
      class CaseAction < ModelElement
        attribute :labels, Expression, collection: true
        attribute :statement, Statement
      end
    end
  end
end
