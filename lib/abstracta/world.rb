module Abstracta
  class World
    extend Forwardable
    attr_reader :age, :grid, :territories, :compass
    def_delegators :grid, :width, :height
    def_delegators :compass, :distance_from

    def initialize(geometry=[100,100], opts={})
      @grid            = Grid.new(geometry)
      @compass         = Compass.default
      @density         = opts.delete(:density) { 0.05 }
      @territory_count = opts.delete(:territory_count) { width * height * @density }
      @territories = []
      @territories = create_territories(@territory_count)
      update_map

      @age = 0
    end

    def update_map
      @occupied = compute_occupied
    end

    def territory_class; Territory end
    def create_territories(n=1)
      seeds = @grid.sample(n)
      Array.new(n) { territory_class.new([seeds.pop]) }
    end

    def step
      old_size = occupied.size
      @age = @age + 1
      update_territories
      occupied.size - old_size
    end

    def update_territories
      @territories.each do |territory|
	update_map
	targets = compute_projected_targets(territory)
	territory.step(targets) 
      end
    end

    def occupied
      @occupied ||= compute_occupied
    end

    def compute_occupied
      territories.map(&:occupants).flatten.map(&:location)
    end

    def occupied?(xy)
      @occupied.include?(xy)
    end

    def compute_projected_targets(territory, n=territory.projected_growth)
      available_adjacent(territory).take(n)
    end

    def available_adjacent(territory)
      @grid.clip territory.adjacent.reject(&method(:occupied?)) # { |xy| occupied.include?(xy) } # & available # - occupied
    end
  end
end

#
