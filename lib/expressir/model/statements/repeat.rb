module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.9 Repeat statement
      class Repeat < Statement
        include Identifier

        attribute :bound1, Expression
        attribute :bound2, Expression
        attribute :increment, Expression
        attribute :while_expression, Expression
        attribute :until_expression, Expression
        attribute :statements, Statement, collection: true

        # @return [Array<Declaration>]
        def children
          [
            self,
            *remark_items,
          ]
        end
      end
    end
  end
end
