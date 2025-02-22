module Expressir
  module Model
    # Multi-schema global scope
    class Repository < ModelElement
      attribute :schemas, Expressir::Model::Declarations::Schema, collection: true
      attribute :_class, :string, default: -> { self.send(:name) }
      attribute :source, :string

      # TODO: Add basic mappings that can be inherited by all subclasses
      # key_value do
      #   map 'schemas', to: :schemas
      # end
      key_value do
        map "_class", to: :_class, render_default: true
        map "source", to: :source
        map "schemas", to: :schemas
      end

      # TODO: Implement schema selection mechanism ("select_proc")

      # @return [Array<Declaration>]
      def children
        [
          *schemas,
        ]
      end
    end
  end
end
