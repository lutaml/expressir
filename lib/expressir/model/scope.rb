module Expressir
  module Model
    module Scope
      def find(path)
        path.downcase.split(".").reduce(self) do |acc, curr|
          if acc and acc.class.method_defined? :children
            acc.children.find{|x| x.id.downcase == curr}
          end
        end
      end

      def children
        raise 'Not implemented'
      end
    end
  end
end