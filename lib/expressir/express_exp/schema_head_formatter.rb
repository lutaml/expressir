require "expressir/express_exp/formatter"

module Expressir
  module ExpressExp
    class SchemaHeadFormatter < Formatter
      def format_schema(node)
        [
          "SCHEMA #{node.id}#{node.version ? " #{format(node.version)}" : ""};",
          *node.interfaces.map{|x| format(x)}
        ].join("\n")
      end
    end
  end
end