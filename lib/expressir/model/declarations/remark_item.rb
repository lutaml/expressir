module Expressir
  module Model
    module Declarations
      # Implicit item with remarks
      class RemarkItem < ModelElement
        attribute :id, :string
        attribute :remarks, :string, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "id", to: :id
          map "remarks", to: :remarks
        end
      end
    end
  end
end
