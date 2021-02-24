module Expressir
  module Model
    module Statements
      class Call < ModelElement
        attr_accessor :ref
        attr_accessor :parameters

        def initialize(options = {})
          @ref = options[:ref]
          @parameters = options.fetch(:parameters, [])

          super
        end
      end
    end
  end
end