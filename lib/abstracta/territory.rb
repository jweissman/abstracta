require 'parallel'
module Abstracta
  class Territory
    extend Forwardable
    include Enumerable
    attr_reader :age, :dna, :occupants, :compass
    def_delegators :dna, :growth_cycle, :growth_radius, :mobile, :sterile, :growth_limit
    def_delegators :occupants, :[], :size, :each

    def_delegators :compass, :project, :move

    def initialize(locations=[])
      @compass = Compass.new
      @occupants = locations.map { |l| Occupant.new([l.x,l.y]) }
      @dna = Genome.default
      @age = 0
    end

    def to_s
      "territory of size #{size} with genome #{dna}"
    end

    def step(growth_targets=[])
      @age = @age + 1
      if @age % growth_cycle == 0 && !growth_targets.empty?
	grow(growth_targets)
      end
      @occupants.each(&:step)
    end

    def grow(available)
      target = (available & adjacent).sample
      @occupants << Occupant.new([target.x, target.y])
    end

    #protected
    # since technically we only need to project the edges
    # this is maybe somewhat wasteful
    def adjacent
      map { |occupant| project(occupant) }.flatten(1).uniq - to_a
    end
  end
end
