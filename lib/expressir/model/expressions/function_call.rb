module Expressir
  module Model
    module Expressions
      # Specified in ISO 10303-11:2004
      # - section 12.8 Function call
      class FunctionCall < ModelElement
        attribute :function, ModelElement
        attribute :parameters, ModelElement, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "function", to: :function
          map "parameters", to: :parameters
        end
      end
    end
  end
end
