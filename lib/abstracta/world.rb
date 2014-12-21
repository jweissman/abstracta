module Abstracta
  class World
    extend Forwardable
    attr_reader :age, :grid, :territories, :compass
    def_delegators :grid, :width, :height
    def_delegators :compass, :distance_from

    def initialize(geometry=[10,10], opts={})
      @grid            = Grid.new(geometry)
      @compass         = Compass.default
      @density         = opts.delete(:density) { 0.5 }
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
	targets = compute_adjacent_available(territory)
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

    def center
      [@occupied.map(&:x).mean.to_i, @occupied.map(&:y).mean.to_i]
    end

    def distance_from_center(p)
      Compass.distance(center,p)
    end

    def compute_adjacent_available(territory, n=territory.projected_growth)
      available_adjacent = territory.adjacent.reject(&method(:occupied?)) # { |xy| occupied.include?(xy) } # & available # - occupied
      @grid.clip(available_adjacent).sort_by(&method(:distance_from_center)).take(n) 
    end
  end
end

#
