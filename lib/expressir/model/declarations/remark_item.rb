module Expressir
  module Model
    module Declarations
      # Implicit item with remarks
      class RemarkItem < ::Expressir::Model::Declaration
        attribute :id, :string
        attribute :remarks, :string, collection: true
      end
    end
  end
end
