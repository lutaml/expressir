module Expressir
  module Express
    module LiteralsFormatter
      private

      def format_literals_binary(node)
        [
          "%",
          node.value,
        ].join
      end

      def format_literals_integer(node)
        node.value
      end

      def format_literals_logical(node)
        case node.value
        when Model::Literals::Logical::TRUE then "TRUE"
        when Model::Literals::Logical::FALSE then "FALSE"
        when Model::Literals::Logical::UNKNOWN then "UNKNOWN"
        end
      end

      def format_literals_real(node)
        node.value
      end

      def format_literals_string(node)
        if node.encoded
          [
            "\"",
            node.value,
            "\"",
          ].join
        else
          [
            "'",
            node.value,
            "'",
          ].join
        end
      end
    end
  end
end
