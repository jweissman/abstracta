module Abstracta
  class World < Straightedge::Figures::Grid
    extend Forwardable
    attr_reader :age, :scale, :territories, :developer
    def_delegators :developer, :step

    def initialize(geometry=[10,10], opts={})
      super(geometry)
      @scale = opts.delete(:scale) { 50.0 }
      @age             = 0
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
      seeds = sample(n)
      Array.new(n) { territory_class.new([seeds.pop]) }
    end

    def age!
      @age = @age + 1
    end

    def occupied
      @occupied ||= compute_occupied
    end

    def occupants
      territories.map(&:occupants).flatten
    end

    def compute_occupied
      @occupied = occupants.flatten.map(&:location)
    end

    def occupied?(xy)
      occupied.include?(xy)
    end

    def territory_at(xy)
      territories.detect { |t| t.occupants.map(&:location).include?(xy) }
    end

    def at(xy)	
      c = color_at(xy)
      Straightedge::Figures::Mark.new(*xy, color: c) # color_at(xy))
    end

    def color_at(xy)
      compute_occupied if occupied?(xy) && !territory_at(xy)
      occupied?(xy) ? territory_at(xy).color : :none
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
