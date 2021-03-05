module Expressir
  module ExpressExp
    module SchemaHeadFormatter
      def format_schema(node)
        [
          "SCHEMA #{node.id}#{node.version ? " #{format(node.version)}" : ""};",
          *node.interfaces.map{|x| format(x)}
        ].join("\n")
      end
    end
  end
end