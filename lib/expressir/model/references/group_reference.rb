module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.7.4 Group references
      class GroupReference < Reference
        attribute :ref, ::Expressir::Model::Reference
        attribute :entity, ::Expressir::Model::Reference
      end
    end
  end
end
