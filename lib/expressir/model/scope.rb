module Expressir
  module Model
    module Scope
      def find(path)
        current, rest = path.downcase.split(".", 2)

        child = children.find{|x| x.id.downcase == current}

        if rest
          if child.class.method_defined? :find
            child.find(rest)
          else
            nil
          end
        else
          child
        end
      end

      def children
        raise 'Not implemented'
      end
    end
  end
end