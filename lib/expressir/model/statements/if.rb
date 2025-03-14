module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.7 If ... Then ... Else statement
      class If < ModelElement
        attribute :expression, ModelElement
        attribute :statements, ModelElement, collection: true
        attribute :else_statements, ModelElement, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "expression", to: :expression
          map "statements", to: :statements
          map "else_statements", to: :else_statements
        end
      end
    end
  end
end
