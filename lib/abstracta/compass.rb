module Abstracta
  class Compass
    extend Forwardable
    attr_accessor :rose
    def_delegator :rose, :project

    def initialize(rose=Rose.extended)
      @rose = rose
    end

    def move(point, direction)
      Compass.translate point, to(direction)
    end

    def to(label) 
      @rose.directions[label] 
    end

    class << self
      def default
	@default_compass ||= new
      end

      def translate(point, delta)
	point.zip(delta).map { |x,y| x + y }
      end

      def distance(alpha,beta)
	dx, dy = alpha.x - beta.x, alpha.y - beta.y
	Math.sqrt(dx*dx + dy*dy)
      end
    end
  end
end
