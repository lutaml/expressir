module Expressir
  module Model
    module References
      # Specified in ISO 10303-11:2004
      # - section 12.3.1 Binary indexing
      # - section 12.5.1 String indexing
      # - section 12.6.1 Aggregate indexing
      class IndexReference < Reference
        attribute :ref, ::Expressir::Model::Reference
        attribute :index1, Expressir::Model::Expression
        attribute :index2, Expressir::Model::Expression
      end
    end
  end
end
