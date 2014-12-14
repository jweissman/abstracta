module Abstracta
  class Grid
    include Enumerable

    attr_reader :dimensions


    DEFAULT_WIDTH = 10
    DEFAULT_HEIGHT = 10

    def initialize(geometry=[DEFAULT_WIDTH,DEFAULT_HEIGHT], compass=Compass.new, opts={}, &blk)
      @dimensions = geometry
      @compass    = compass
    end

    def width
      @dimensions.x
    end

    def height
      @dimensions.y
    end

    def each
      elements = []
      Array.new(width) do |x|
	Array.new(height) do |y|
	  if (c=yield(x,y))
	    elements << c 
	  end
	end
      end

      elements
    end
  end
end
