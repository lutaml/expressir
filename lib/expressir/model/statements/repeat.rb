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
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "bound1", to: :bound1
          map "bound2", to: :bound2
          map "increment", to: :increment
          map "while_expression", to: :while_expression
          map "until_expression", to: :until_expression
          map "statements", to: :statements
        end

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
