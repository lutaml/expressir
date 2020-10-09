module Expressir
  module Model
    module Expressions
      class QualifiedRef
        attr_accessor :ref
        attr_accessor :qualifiers

        def initialize(options = {})
          @ref = options[:ref]
          @qualifiers = options[:qualifiers]
        end
      end
    end
  end
end