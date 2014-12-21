require 'parallel'
module Abstracta
  class Territory
    include Enumerable
    extend Forwardable
    def_delegators :occupants, :[], :size, :each

    attr_reader :age, :dna, :occupants, :compass

    def initialize(locations=[],genome=Genome.default)
      @compass = Compass.default
      @occupants = locations.map(&method(:occupant_at))
      @dna = genome
      @cycle = @dna.growth.cycle
      @rate  = @dna.growth.rate
      @limit = @dna.growth.limit
      @age = 0
    end

    def step(targets=adjacent)
      @occupants.each(&:step)
      @age = @age + 1
      return grow(targets)
    end

    def grow(available=adjacent,n=projected_growth)
      return unless growth_indicated? 
      targets = available & adjacent
      return if targets.empty?

      old_size = size
      targets.sample(n).each do |target|
	@occupants << occupant_at(target)
	break if size >= @limit
      end

      growth_count = size - old_size
      if growth_count > 0
	@occupied = to_a
	@adjacent = compute_adjacent
      end
      growth_count
    end

    def occupant_class; Occupant end
    def projected_size; @rate * size end
    def projected_growth; projected_size - size end

    def occupant_at(p)
      occupant_class.new([p.x,p.y]) 
    end

    def growth_indicated?
      @age % @cycle == 0 && size <= @limit
    end

    def occupied
      @occupied ||= to_a
    end

    def adjacent
      @adjacent ||= compute_adjacent
    end

    def compute_adjacent
      map { |occupant| @compass.project(occupant) }.flatten(1).uniq - occupied
    end
  end
end
