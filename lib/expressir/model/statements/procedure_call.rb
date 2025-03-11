module Expressir
  module Model
    module Statements
      # Specified in ISO 10303-11:2004
      # - section 13.8 Procedure call statement
      class ProcedureCall < ModelElement
        attribute :procedure, ModelElement
        attribute :parameters, ModelElement, collection: true
        attribute :_class, :string, default: -> { self.send(:name) }
        attribute :source, :string

        key_value do
          map "_class", to: :_class, render_default: true
          map "source", to: :source
          map "procedure", to: :procedure
          map "parameters", to: :parameters
        end
      end
    end
  end
end
