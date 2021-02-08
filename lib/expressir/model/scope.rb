module Expressir
  module Model
    module Scope
      def find(path)
        current_path, _, rest = path.partition(".")

        # ignore prefix
        _, _, current_path = current_path.rpartition(":")

        current_path = current_path.downcase
        child = children.find{|x| x.id and x.id.downcase == current_path}

        if !rest.empty? and child.class.method_defined? :find
          child.find(rest)
        else
          child
        end
      end

      def find_or_create(path)
        child = find(path)

        if !child
          # check if path should create implicit informal proposal
          # see https://github.com/lutaml/expressir/issues/50
          rest, _, current_path = path.rpartition(".")

          if !rest.empty?
            child = find(rest)
          else
            child = self
          end

          if child.class.method_defined? :informal_propositions
            # ignore prefix
            _, _, current_path = current_path.rpartition(":")

            # match informal proposition id
            informal_proposition_id = current_path.match(/^IP\d+$/).to_a[0]

            if informal_proposition_id
              # create implicit informal proposition
              informal_proposition = Model::InformalProposition.new({
                id: informal_proposition_id
              })
              informal_proposition.parent = child

              child.informal_propositions << informal_proposition

              informal_proposition
            end
          end
        else
          child
        end
      end

      def attach_parent_to_children
        children.each do |child_node|
          if child_node.class.method_defined? :parent and !child_node.parent
            child_node.parent = self
          end
        end
      end

      def children
        raise 'Not implemented'
      end
    end
  end
end