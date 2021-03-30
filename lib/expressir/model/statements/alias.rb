module Expressir
  module Model
    module Statements
      class Alias < ModelElement
        include Identifier

        model_attr_accessor :expression
        model_attr_accessor :statements

        def initialize(options = {})
          @id = options[:id]
          @remarks = options[:remarks] || []
          @remark_items = options[:remark_items] || []
          @source = options[:source]

          @expression = options[:expression]
          @statements = options[:statements] || []

          super
        end

        def children
          [
            self,
            *remark_items
          ]
        end
      end
    end
  end
end