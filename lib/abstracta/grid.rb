module Abstracta
  class Grid
    extend Forwardable
    include Enumerable

    attr_reader :dimensions
    def_delegator :@dimensions, :x, :width
    def_delegator :@dimensions, :y, :height
    #def_delegator :@dimensions, :z, :depth
    #def_delegator :@dimensions, :t, :duration

    DEFAULT_WIDTH = 10
    DEFAULT_HEIGHT = 10

    def initialize(geometry=[DEFAULT_WIDTH,DEFAULT_HEIGHT], compass=Compass.new, opts={}, &blk)
      @dimensions = geometry
      @compass    = compass
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
