module Expressir
  module Model
    module Declarations
      # Implicit item with remarks
      class RemarkItem < ::Expressir::Model::Declaration
        attribute :id, :string
        attribute :remarks, :string, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "id", to: :id
          map "remarks", to: :remarks
        end
      end
    end
  end
end
