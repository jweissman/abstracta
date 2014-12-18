module Abstracta
  class Explorer
    attr_reader :grid
    def initialize(geometry) #world=nil)
      #@world = world
      # grid and compass are really 'helper' classes
      # we could 'fold' them  into higher-order helpers, maybe even overload an operator?
      @grid = Grid.new(geometry)
      @compass = Compass.new
    end

    def available?(p, territories=[])
      return true if territories.empty?
      territories.map(&:occupants).any? do |o|
	[o.x,o.y] == [p.x,p.y]
      end
    end

    def available(territories=[]) #(territory=nil, neighbors=[])
      @grid.select { |p| available?(p, territories) } # if territory.nil? #empty?
    end

    #def adjacent(territory)
    #  rough_projected = territory.map { |o| @compass.project([o.x,o.y]) }.flatten(1)
    #  rough_projected.uniq - territory.to_a
    #end
  end
end
