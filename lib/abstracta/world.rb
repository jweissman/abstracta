module Abstracta
  class World
    extend Forwardable
    attr_reader :age, :grid, :territories, :developer

    def_delegators :grid, :x, :y
    def_delegators :developer, :step
    #def_delegators :compass, :distance_from

    def initialize(geometry=[100,100], opts={})
      @age = 0

      @grid            = Grid.new(geometry)
      @density         = opts.delete(:density) { 0.05 }

      @territory_count = opts.delete(:territory_count) { x * y * @density }
      @territories = []
      @territories = create_territories(@territory_count)
      update_map

      @developer = WorldDeveloper.new(self)
    end

    def update_map
      @occupied = compute_occupied
    end

    def territory_class; Territory end
    def create_territories(n=1)
      seeds = @grid.sample(n)
      Array.new(n) { territory_class.new([seeds.pop]) }
    end

    def age!
      @age = @age + 1
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

    def compute_projected_targets(territory, n=territory.growth)
      available_adjacent(territory).take(n)
    end

    def available_adjacent(territory)
      @grid.clip territory.adjacent.reject(&method(:occupied?))
    end
  end
end

#
