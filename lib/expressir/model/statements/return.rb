module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.10 Return statement
      class Return < ModelElement
        attribute :expression, ModelElement
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "expression", to: :expression
        end
      end
    end
  end
end
