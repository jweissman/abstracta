require 'parallel'
module Abstracta
  class Territory
    include Enumerable
    extend Forwardable
    def_delegators :occupants, :[], :size, :each

    attr_reader :age, :dna, :occupants, :compass

    def initialize(locations=[],genome=Genome.default)
      @compass   = Compass.default
      @occupants = locations.map(&method(:occupant_at))
      @dna       = genome
      @cycle     = @dna.growth.cycle
      @rate      = @dna.growth.rate
      @limit     = @dna.growth.limit
      @max_age   = @dna.age_bound
      @age       = 0
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
      
      # cull
      @occupants.reject! { |o| o.age >= @max_age }

      growth_count = size - old_size
      @occupied = to_a
      @adjacent = compute_adjacent
      growth_count
    end

    def occupant_class; Occupant end
    def projected_size; @rate + size end
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

    def occupies?(xy)
      occupied.include?(xy)
    end

    def adjacent
      @adjacent ||= compute_adjacent
    end

    def compute_adjacent
      all_projections = map { |occupant| @compass.project(occupant) }.flatten(1).uniq 
      adj = all_projections.reject(&method(:occupies?)) # - occupied)
      adj.sort_by(&method(:distance_from_center))
    end

    def center
      [@occupants.map(&:x).mean.to_i, @occupants.map(&:y).mean.to_i]
    end

    def distance_from_center(p)
      Compass.distance(center,p)
    end
  end
end
