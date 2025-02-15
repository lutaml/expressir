module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.2 Integer literal
      class Integer < Literal
        attribute :value, :string
      end
    end
  end
end
