module Abstracta
  class Rose
    attr_reader :directions
    def initialize(directions:{})
      @directions = directions
    end

    class << self
      def simple
	new directions: {
	  :north => [0, -1],
	  :south => [0,  1],
	  :east  => [1,  0],
	  :west  => [-1, 0]
	} 
      end

      def extended
	simple_rose_axes = [[:east,:west],[:north, :south]]
	extended_directions = combinate(simple, simple_rose_axes)
	all_directions = simple.directions.merge(extended_directions)
	new directions: all_directions
      end

      def combinate(base, axes)
	combinations = axes.first.map do |y|
	  axes.second.map do |x|
	    ["#{x}#{y}".to_sym, Compass.translate(base.directions[x], base.directions[y])]
	  end
	end

	Hash[combinations.flatten(1)]
      end
    end
  end
end
