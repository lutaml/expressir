require "expressir/express/aggregate_dimension"

module Expressir
  module Express
    class ExplicitAggregate < Explicit
      attr_accessor :rank, :dimensions

      def initialize(options = {})
        @rank = 0
        @dimensions = []
        @isOptional = false

        super(options)
      end

      private

      def extract_type_specific_attributes(document)
        @dimensions = document.xpath("aggregate").map do |aggregate|
          Express::AggregateDimension.parse(aggregate)
        end

        @rank = @dimensions.size
        extract_inverse_aggregate(document)
      end

      # @todo: Non existance attributes
      #
      # In the codebase, they are trying to add couple of aggregate
      # dimensions related attributes that was never a part of the
      # Explict class, but for consistency we are keeping those as
      # it is for now. let's revist those later and fix it.
      #
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
