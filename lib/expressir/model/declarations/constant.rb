module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.4 Constant
      class Constant < ::Expressir::Model::Declaration
        include Identifier

        attribute :type, ::Expressir::Model::DataType
        attribute :expression, ::Expressir::Model::Expression
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "type", to: :type
          map "expression", to: :expression
        end

        # @return [Array<Declaration>]
        def children
          [
            *remark_items,
          ]
        end
      end
    end
  end
end
