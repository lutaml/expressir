module Expressir
  module Model
    module Declarations
      # Implicit item with remarks
      class RemarkItem < ModelElement
        include HasId
        include HasRemarks

        attribute :id, :string
        attribute :remarks, :string, collection: true, initialize_empty: true
        # The texts of the `--IPn:` comment lines of the source (empty for a
        # bare marker); the plain form writes these and no other text.
        attribute :source_remarks, :string, collection: true
        attribute :_class, :string, default: -> { self.class.name }

        key_value do
          map "_class", to: :_class, render_default: true
          map "id", to: :id
          map "remarks", to: :remarks
          map "source_remarks", to: :source_remarks
        end
      end
    end
  end
end
