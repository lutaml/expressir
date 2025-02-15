module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.3 Attribute references
      class AttributeReference < Reference
        attribute :ref, ::Expressir::Model::Reference
        attribute :attribute, ::Expressir::Model::Reference
      end
    end
  end
end
