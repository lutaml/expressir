module Expressir
  module Model
    # Cache content object with Expressir version
    class Cache < ModelElement
      attribute :version, :string
      attribute :root_path, :string
      attribute :content, ModelElement
    end
  end
end
