module Abstracta
  class Grid
    extend Forwardable
    include Enumerable

    attr_reader :dimensions, :elements
    def_delegator :dimensions, :x, :width
    def_delegator :dimensions, :y, :height
    def_delegators :elements, :each, :sample, :flatten, :to_a

    def initialize(geometry=[10,10], compass=Compass.new, opts={}, &blk)
      @dimensions = geometry
      @compass    = compass
      compute_elements
    end

    def compute_elements
      @elements = []
      width.times do |x|
	height.times do |y|
	  @elements << [x,y]
	end
      end
    end

    def each
      @elements.each { |p| yield(p) }
    end

    def clip(xys=[])
      xys.reject do |xy|
	x,y = *xy
	x < 0 || y < 0 || x >= width || y >= height
      end 
    end
  end
end
