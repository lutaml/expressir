module Expressir
  module Model
    module Statements
      class Alias < ModelElement
        include Identifier

        model_attr_accessor :expression
        model_attr_accessor :statements

        def initialize(options = {})
          @id = options[:id]
          @remarks = options.fetch(:remarks, [])
          @remark_items = options.fetch(:remark_items, [])
          @source = options[:source]

          @expression = options[:expression]
          @statements = options.fetch(:statements, [])

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