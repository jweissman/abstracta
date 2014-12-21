module Abstracta
  class World
    extend Forwardable
    attr_reader :age, :grid, :territories
    def_delegators :grid, :width, :height

    def initialize(geometry=[5,5], opts={})
      @grid = Grid.new(geometry)
      @compass = Compass.new

      @density = opts.delete(:density) { 0.05 }
      @territory_count = opts.delete(:territory_count) { width * height * @density }
      @territories = []
      @territories = create_territories(@territory_count)
      @age = 0
    end

    def step
      @age = @age + 1
      update_territories
    end

    def occupied
      territories.map(&:occupants).flatten.map(&:location)
    end

    def space
      @space ||= @grid.to_a
    end

    def available
      space - occupied
    end

    # pick n territorities of size m
    def territory_class; Territory end
    def create_territories(n=1,m=1)
      as = available.sample(m*n)
      Array.new(n) { territory_class.new(as.shift(m)) }
    end

    def update_territories
      @territories.each do |territory|
	territory.step(available)
      end
    end
  end
end

#
