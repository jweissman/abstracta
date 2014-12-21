module Abstracta
  class Compass
    attr_accessor :rose

    def initialize(rose=Rose.simple)
      @rose = rose
    end

    def move(point, direction)
      Compass.translate point, to(direction)
    end

    def to(label) 
      @rose.directions[label] 
    end

    def deltas
      @rose.directions.values
    end

    class << self
      def translate(point, delta)
	point.zip(delta).map { |x,y| x + y }
      end
    end
  end
end
