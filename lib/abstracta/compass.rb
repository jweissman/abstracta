module Abstracta
  class Compass
    attr_accessor :rose

    def initialize(rose=Compass.simple_rose)
      @rose = rose
    end

    # this method seems a little confusing...
    # tempted to remove it honestly
    def project(point)
      deltas.collect { |dx| Compass.translate(point, dx) }
    end

    def move(point, direction)
      Compass.translate point, to(direction)
    end

    def direction_between(a,b)
      @rose.detect { |_,dx| Compass.translate(a,dx) == b }.first
    end

    protected

    def to(label) 
      @rose[label] 
    end

    def deltas
      @rose.values
    end

    class << self
      def translate(point, delta)
	point.zip(delta).map { |x,y| x + y }
      end

      def simple_rose
	{
	  :north => [0, -1],
	  :south => [0,  1],
	  :east  => [1,  0],
	  :west  => [-1, 0]
	} 
      end

      def combinate_rose(base_rose, axes)
	combinations = axes[0].map do |y|
	  axes[1].map do |x|
	    ["#{x}#{y}".to_sym, translate(simple_rose[x], simple_rose[y])]
	  end
	end
	Hash[combinations.flatten(1)]
      end

      def extended_rose
	simple_rose_axes = [[:east,:west],[:north, :south]]
	combinated_rose = combinate_rose(simple_rose, simple_rose_axes)
	simple_rose.merge(combinated_rose)
      end
    end
  end
end
