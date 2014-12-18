module Abstracta
  class Grid
    extend Forwardable
    include Enumerable

    attr_reader :dimensions
    def_delegator :@dimensions, :x, :width
    def_delegator :@dimensions, :y, :height
    #def_delegator :@dimensions, :z, :depth
    #def_delegator :@dimensions, :t, :duration

    def_delegators :to_a, :flatten, :sample # :zip...

    DEFAULT_WIDTH = 10
    DEFAULT_HEIGHT = 10

    def initialize(geometry=[DEFAULT_WIDTH,DEFAULT_HEIGHT], compass=Compass.new, opts={}, &blk)
      @dimensions = geometry
      @compass    = compass
    end

    def each
      Array.new(width) do |x|
	Array.new(height) do |y|
	  yield(x,y)
	end
      end
    end
  end
end
