module Expressir
  module Model
    # Multi-schema global scope
    class Repository < ModelElement
      attribute :schemas, Expressir::Model::Declarations::Schema, collection: true
      attribute :_class, :string, default: -> { self.send(:name) }

      key_value do
        map "_class", to: :_class, render_default: true
        map "schemas", to: :schemas
      end

      # @return [Array<Declaration>]
      def children
        [
          *schemas,
        ]
      end
    end
  end
end
