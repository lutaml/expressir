module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 9.5.3.3 Generic entity data type
      class GenericEntity < DataType
        include Identifier

        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
        end
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
