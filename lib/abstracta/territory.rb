module Abstracta
  class Territory
    include Entity
    include Enumerable
    extend  Forwardable

    def_delegators :occupants, :size, :each #, :include?, :adjacent, :center
    def_delegators :to_a, :[], :first, :center

    alias :occupy? :include?

    attr_reader :dna
    attr_reader :occupants
    attr_reader :compass, :developer
    attr_reader :period, :limit
    attr_reader :color
    attr_reader :world

    def initialize(locations=[[0,0]], genome: Genome.default, 
		                      color: Straightedge::Colors.pick,
				      world: nil)

      @compass   = Straightedge::Toolkit::Compass.default
      @occupants = locations.map(&method(:occupant_at))
      @color     = color
      @world     = world
      #puts "=== new territory with color #{@color} and occupants: #{occupants}"
      parse_dna(genome)
    end

    def to_a; @occupants.map(&:location) end
    #def adjacent; map(&:adjacent) end
    #def center;   map(&:center)   end
    #def each_occupant; @occupants.each(&method(:yield)) end
    def adjacent; (to_a.adjacent) end

    def parse_dna(genome)
      @dna       = genome.tap do |my|
        @period    = my.growth.cycle
        @rate      = my.growth.rate
        @limit     = my.growth.limit
        @max_age   = my.age_bound
      end
    end

    def projected_size
      (@rate.additive + size) * @rate.multiplicative 
    end

    def growth
      projected_size - size 
    end

    def occupant_at(point)
      Abstracta.new_occupant([point.x, point.y], territory: self, world: world)
    end

    def occupy!(target)
      @occupants << occupant_at(target)
    end

    def cull!
      @occupants.reject! do |occupant| 
	occupant.age >= @max_age
      end
    end
  end
end
