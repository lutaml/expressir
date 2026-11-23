module Expressir
  module Model
    module Declarations
      # Implicit item with remarks
      class RemarkItem < ModelElement
        include HasId
        include HasRemarks

        attribute :id, :string
        attribute :remarks, :string, collection: true, initialize_empty: true
        attribute :_class, :string, default: -> { self.class.name }

        key_value do
          map "_class", to: :_class, render_default: true
          map "id", to: :id
          map "remarks", to: :remarks
          # The IP shorthand lines land here (#723); the annotated YAML
          # has to carry them like every other element's untagged lane.
          map "untagged_remarks", to: :untagged_remarks
        end
      end
    end
  end
end
