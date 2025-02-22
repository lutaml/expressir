module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.8 Function call
      class FunctionCall < Expression
        attribute :function, ::Expressir::Model::Reference
        attribute :parameters, Expression, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "function", to: :function
          map "parameters", to: :parameters
        end
      end
    end
  end
end
