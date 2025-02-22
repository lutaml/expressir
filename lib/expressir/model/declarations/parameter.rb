module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.5.3 Parameters
      class Parameter < ::Expressir::Model::Declaration
        include Identifier

        attribute :var, :boolean
        attribute :type, ::Expressir::Model::DataType
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "var", to: :var
          map "type", to: :type
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
