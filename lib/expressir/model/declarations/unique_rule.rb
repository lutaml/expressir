module Expressir
  module Model
    module Declarations
      # Specified in ISO 10303-11:2004
      # - section 9.2.2.1 Uniqueness rule
      class UniqueRule < ::Expressir::Model::Declaration
        include Identifier

        attribute :attributes, ::Expressir::Model::Reference, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "attributes", to: :attributes
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
