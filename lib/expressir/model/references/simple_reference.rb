module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.1 Simple references
      class SimpleReference < Reference
        attribute :id, :string
        attribute :ref, ::Expressir::Model::Reference
        attribute :base_path, :string
      end
    end
  end
end
