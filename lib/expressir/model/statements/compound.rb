module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.5 Compound statement
      class Compound < Statement
        attribute :statements, Statement, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "statements", to: :statements
        end
      end
    end
  end
end
