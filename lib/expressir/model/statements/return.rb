module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.10 Return statement
      class Return < Statement
        attribute :expression, Expression
      end
    end
  end
end
