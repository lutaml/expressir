module Expressir
  module Model
    module Identifier
      def self.included(mod)
        mod.attribute :id, :string
        mod.attribute :remarks, :string, collection: true
        mod.attribute :remark_items,
                      ::Expressir::Model::Declarations::RemarkItem, collection: true
        mod.attribute :untagged_remarks, :string, collection: true

        mod.key_value do
          map "id", to: :id
          map "remarks", to: :remarks
          map "remark_items", to: :remark_items
          map "untagged_remarks", to: :untagged_remarks
        end
      end
    end
  end
end
