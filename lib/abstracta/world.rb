module Abstracta
  class World < Straightedge::Figures::Grid
    include Entity
    extend Forwardable

    def_delegator :occupants, :size

    attr_accessor :scale, :territories, :status

    def initialize(dimensions=Abstracta.config.geometry, opts={})
      @dimensions      = dimensions
      #puts "--- creating world with dimensions #{@dimensions}"
      @density         = opts.delete(:density)         { Abstracta.config.density }
      @territory_count = opts.delete(:territory_count) { width * height * @density }
      @scale           = opts.delete(:scale)           { Abstracta.config.scale }
      @status = "Initializing"
      super(dimensions, scale: @scale)
       
      create_territories(@territory_count)
      #puts "--- created #{@territories.size} territories"
    end

    def projected_growth
      @territories.sum(&:growth) # { |t| t.projected_growth
    end

    def create_territories(n)
      @territories = []
      sample(n).each do |seed|
	@territories << territory_at([seed])
      end
    end

    def visible?(xy)
      occupied.include?(xy) 
    end

    def color_at(xy)
      occupied?(xy) ? detect_territory_at(xy).color : :none
    end

    def each_cell
      each do |xy| 
	cell = cell_at xy
	yield cell if cell && visible?(xy)
      end
    end

    def territory_at(xys)
      Abstracta.new_territory(xys)
    end

    def occupied
      @occupied ||= compute_occupied
    end

    def occupants
      @occupants ||= compute_occupants # territories.map(&:occupants).flatten
    end

    def compute_occupants
      @occupants = territories.map(&:occupants).flatten
    end

    def compute_occupied
      @occupied = compute_occupants.map(&:location)
    end

    def occupied?(xy)
      occupied.include?(xy)
    end

    def occupant_at(xy)
      occupants.detect { |o| o.location == xy }
    end

    def detect_territory_at(xy)
      territories.detect { |t| t.occupants.map(&:location).include?(xy) }
    end

    def surrounding(xy)
      @projections ||= {}
      @projections[xy] ||= project(xy)
      @projections[xy].map(&method(:occupant_at)).compact
    end
  end
end
