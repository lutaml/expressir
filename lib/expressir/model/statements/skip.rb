module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.11 Skip statement
      class Skip < ModelElement
        attribute :_class, :string, default: -> { send(:name) }

        key_value do
          map "_class", to: :_class, render_default: true
        end
      end
    end
  end
end
