module Expressir
  module Express
    class InverseAggregate < Inverse
      attr_accessor :aggrtype, :lower, :upper

      def initialize(options = {})
        @aggrtype = "SET"
        @lower = "0"
        @upper = "?"

        super(options)
      end

      private

      def extract_type_specific_attributes(document)
        @dimensions = document.xpath("aggregate").map do |aggregate|
          Express::AggregateDimension.parse(aggregate)
        end


        extract_inverse_aggregate(document)
      end

      def extract_inverse_aggregate(document)
        aggregates = document.xpath("inverse.aggregate")

        if !aggregates.empty?
          dimension = Express::AggregateDimension.parse(aggregates.first)
          @aggrtype = dimension.aggrtype
          @lower = dimension.lower
          @upper = dimension.upper
        end
      end
    end
  end
end
