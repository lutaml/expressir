module Expressir
  module Model
    # Specified in ISO 10303-11:2004
    # - section 12.7 References
    # @abstract
    class Reference < ModelElement
      attribute :_class, :string, default: -> { self.send(:name) }
      attribute :source, :string

      key_value do
        map "_class", to: :_class, render_default: true
        map "source", to: :source
      end
    end
  end
end
