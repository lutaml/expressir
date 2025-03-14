module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.9 Repeat statement
      class Repeat < ModelElement
        include Identifier

        attribute :bound1, ModelElement
        attribute :bound2, ModelElement
        attribute :increment, ModelElement
        attribute :while_expression, ModelElement
        attribute :until_expression, ModelElement
        attribute :statements, ModelElement, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }

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
