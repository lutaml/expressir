module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.1 Null (statement)
      class Null < ModelElement
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
        end
      end
    end
  end
end
