module Expressir
  module Model
    module DataTypes
      # Specified in ISO 10303-11:2004
      # - section 9.5.3.2 Generic data type
      class Generic < ModelElement
        include Identifier

        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
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
