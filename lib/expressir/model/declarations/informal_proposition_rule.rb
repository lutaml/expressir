module Expressir
  module Model
    module Declarations
      # Informal proposition rules are used to specify constraints that cannot be formally expressed
      class InformalPropositionRule < ModelElement
        include Identifier

        attribute :expression, ModelElement
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "expression", to: :expression
        end

        def children
          [
            *remark_items,
          ]
        end
      end
    end
  end
end
