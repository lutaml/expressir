module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.1 Binary literal
      class Binary < Literal
        attribute :value, :string
      end
    end
  end
end
