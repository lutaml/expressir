module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.4 Case statement
      class CaseAction < ModelElement
        attribute :labels, ModelElement, collection: true
        attribute :statement, ModelElement
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "labels", to: :labels
          map "statement", to: :statement
        end
      end
    end
  end
end
