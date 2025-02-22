module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.4 Case statement
      class Case < Statement
        attribute :expression, Expression
        attribute :actions, CaseAction, collection: true
        attribute :otherwise_statement, Statement
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "expression", to: :expression
          map "actions", to: :actions
          map "otherwise_statement", to: :otherwise_statement
        end
      end
    end
  end
end
