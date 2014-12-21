module Abstracta
  class Rose
    attr_reader :directions
    def initialize(directions:{})
      @directions = directions

      # two level hash
      @projections = Hash.new { Hash.new } 
    end

    def project(point)
      @directions.values.collect do |delta|
	Compass.translate(point, delta)
      end
    end

    class << self
      def simple
	return @simple_rose unless @simple_rose.nil?
	@simple_rose = new directions: {
	  :north => [0, -1],
	  :south => [0,  1],
	  :east  => [1,  0],
	  :west  => [-1, 0]
	} 
      end

      def extended
	return @extended_rose unless @extended_rose.nil?
	simple_rose_axes = [[:east,:west],[:north, :south]]
	extended_directions = combinate(simple, simple_rose_axes)
	all_directions = simple.directions.merge(extended_directions)
	@extended_rose = new directions: all_directions
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
