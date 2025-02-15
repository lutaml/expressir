module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.4 String literal
      class String < Literal
        attribute :value, :string
        attribute :encoded, :boolean
      end
    end
  end
end
