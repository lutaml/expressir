module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.5 Compound statement
      class Compound < Statement
        attribute :statements, Statement, collection: true
      end
    end
  end
end
