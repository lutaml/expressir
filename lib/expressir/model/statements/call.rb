module Expressir
  module Model
    module Statements
      class Call
        attr_accessor :ref
        attr_accessor :parameters

        def initialize(options = {})
          @ref = options[:ref]
          @parameters = options[:parameters]
        end
      end
    end
  end
end