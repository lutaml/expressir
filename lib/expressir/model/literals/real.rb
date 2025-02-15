module Expressir
  module Model
    module Literals
      # Specified in ISO 10303-11:2004
      # - section 7.5.3 Real literal
      class Real < Literal
        attribute :value, :string
      end
    end
  end
end
