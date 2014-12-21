require 'parallel'
module Abstracta
  class Territory
    extend Forwardable
    include Enumerable

    attr_reader :age, :dna, :occupants, :compass
    
    def_delegators :dna, :growth #_cycle, :growth_radius, :mobile, :sterile, :growth_limit, :growth_rate
    def_delegators :occupants, :[], :size, :each

    def initialize(locations=[],genome=Genome.default)
      @compass = Compass.new
      @occupants = locations.map { |l| occupant_at(l) } # occupant_class.new([l.x,l.y]) }
      @dna = genome # Genome.default
      @age = 0
    end

    def occupant_at(p)
      occupant_class.new([p.x,p.y]) 
    end

    def occupant_class; Occupant end

    def projected_size; growth.rate * size end
    def projected_growth; projected_size - size end

    def step(targets=adjacent)
      @occupants.each(&:step)
      @age = @age + 1
      grow(targets)
    end

    def grow(available=adjacent,n=projected_growth)
      return if @age % growth.cycle != 0 || size >= growth.limit # - projected_growth
      targets = available & adjacent
      return if targets.empty?
      targets.sample(n).each do |target|
	@occupants << occupant_at(target)
	break if size >= growth.limit
      end
      @occupied = to_a
      self
    end

    def occupied
      @occupied ||= to_a
    end

    # since technically we only need to project the edges
    # this is maybe somewhat wasteful...
    def adjacent
      # 15% of our time is in this minus here :)
      map { |occupant| project(occupant) }.flatten(1).uniq - occupied
    end

    # this method seems a little confusing...
    # tempted to remove it honestly
    def project(point)
      @compass.deltas.collect { |dx| Compass.translate(point, dx) }
    end
  end
end
