module Abstracta
  class World < Straightedge::Figures::Grid
    extend Forwardable

    attr_reader :age, :scale, :territories, :developer
    def_delegators :developer, :step

    def initialize(dimensions=Straightedge.config.geometry, opts={})
      @age             = 0
      @dimensions      = dimensions
      puts "--- creating world with dimensions #{@dimensions}"
      @density         = opts.delete(:density)         { Abstracta.config.density }
      @territory_count = opts.delete(:territory_count) { width * height * @density }
      @scale           = opts.delete(:scale)           { Abstracta.config.scale }
      super(dimensions, scale: @scale)

      create_territories(@territory_count)
      puts "--- created #{@territories.size} territories"
      @developer = WorldDeveloper.new(self)
    end

    def each_cell
      occupied.each do |xy| 
	yield Straightedge::Figures::Quadrilateral.new(location: to_pixels(xy), color: color_at(xy), dimensions: [@scale, @scale])
      end
    end

    def update_map
      @occupied = compute_occupied
    end

    def create_territories(n)
      puts "--- creating #{n} territories!"
      @territories = []
      sample(n).each do |seed|
	puts "--- creating territory at #{seed}"
	@territories << territory_at([seed])
      end
      update_map
    end

    def territory_at(xys)
      Abstracta.new_territory(xys)
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

    def detect_territory_at(xy)
      territories.detect { |t| t.occupants.map(&:location).include?(xy) }
    end

    #def at(xy)	
    #  c = color_at(xy)
    #  Straightedge::Figures::Mark.new(*xy, color: c) # color_at(xy))
    #end

    def color_at(xy)
      compute_occupied if occupied?(xy) && !detect_territory_at(xy)
      occupied?(xy) ? detect_territory_at(xy).color : :none
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
