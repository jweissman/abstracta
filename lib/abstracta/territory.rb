require 'parallel'
module Abstracta
  class Territory
    extend Forwardable
    include Enumerable

    attr_reader :age, :dna, :occupants, :compass
    
    def_delegators :dna, :growth_cycle, :growth_radius, :mobile, :sterile, :growth_limit, :growth_rate
    def_delegators :occupants, :[], :size, :each
    def_delegators :compass, :project, :move

    def initialize(locations=[])
      @compass = Compass.new
      @occupants = locations.map { |l| occupy(l) } # occupant_class.new([l.x,l.y]) }
      @dna = Genome.default
      @age = 0
    end

    def occupy(p); p.flatten!; occupant_class.new([p.x,p.y]) end
    def occupant_class; Occupant end

    def step(growth_targets=[])
      @occupants.each(&:step)
      @age = @age + 1
      grow(growth_targets, growth_rate * size)
    end

    def grow(available,n=1)
      return if available.empty? || @age % growth_cycle != 0 || size >= growth_limit
      target = (available & adjacent).sample(n)
      @occupants << occupy(target) # occupant_class.new([target.x, target.y])
    end

    # since technically we only need to project the edges
    # this is maybe somewhat wasteful...
    def adjacent
      map { |occupant| project(occupant) }.flatten(1).uniq - to_a
    end
  end
end
