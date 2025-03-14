module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.6 Escape statement
      class Escape < ModelElement
        attribute :_class, :string, default: -> { self.send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
        end
      end
    end
  end
end
