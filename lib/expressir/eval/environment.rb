# frozen_string_literal: true

module Expressir
  module Eval
    # Lexical scope chain: a name resolves to a value through the
    # innermost scope that declares it. The schema provides type
    # context; the population (step 3) provides instances for the
    # instance-aware builtins.
    class Environment
      attr_reader :schema, :population

      def initialize(schema:, population: nil, frames: [{}])
        @schema = schema
        @population = population
        @frames = frames
      end

      def push(frame)
        Environment.new(schema: @schema, population: @population,
                        frames: @frames + [frame])
      end

      def define(name, value)
        frame = @frames.last.dup
        frame[name.safe_downcase] = value
        Environment.new(schema: @schema, population: @population,
                        frames: @frames[0..-2] + [frame])
      end

      def lookup(name)
        key = name.safe_downcase
        @frames.reverse_each do |frame|
          return frame[key] if frame.key?(key)
        end
        nil
      end

      def bound?(name)
        !lookup(name).nil? || @frames.any? { |f| f.key?(name.safe_downcase) }
      end
    end
  end
end
