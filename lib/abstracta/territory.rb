require 'parallel'
module Abstracta
  class Territory
    extend Forwardable

    attr_reader :age
    attr_reader :occupants
    attr_reader :dna

    def_delegators :dna, :growth_cycle, :growth_radius, :mobile, :sterile, :growth_limit

    def initialize(occupants=[])
      raise "occupants is not an array?" unless occupants.is_a?(Array)

      @age = 0
      @occupants = occupants
      @dna = Genome.default
      @compass = Compass.new
    end

    def to_s
      "territory of size #{size} with genome #{dna}"
    end

    def size; @occupants.size end

    def adjacent_spaces
      @occupants.collect { |o| @compass.project(o) }.flatten(1) #[o.x, o.y]) } 
    end

    # stuff that requires a world... let's factor this out somehow?

    def step(world=nil)
      @age = @age + 1
      grow(world) if @age % growth_cycle == 0
      @occupants.each(&:step)
    end

    def grow_targets(world=nil)
      return adjacent_spaces unless world
      adjacent_spaces.select do |space|
        world.available?(space)
      end
    end

    def grow(world=nil)
      target = grow_targets(world).sample
      @occupants << Occupant.new(target.x, target.y)
    end

    def self.generate(n=1,world=nil)
      new(Array.new(n) {Occupant.generate(world)}) 
    end

    #def contains?(x,y)
    #  @occupants.any? { |(_x,_y)| x == _x && y == _y }
    #end

    #def grow(locations)
    #  @territory + locations
    #end

    #def develop
    #  @territory = grow(field.adjacent)
    #end
  end
end
