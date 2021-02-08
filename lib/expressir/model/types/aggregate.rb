module Expressir
  module Model
    module Types
      class Aggregate < ModelElement
        include Identifier

        attr_accessor :base_type

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @source = options[:source]

          @base_type = options[:base_type]
        end
      end
    end
  end
end