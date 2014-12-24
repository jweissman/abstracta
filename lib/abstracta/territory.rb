module Abstracta
  class Territory
    include Enumerable
    extend Forwardable

    def_delegators :occupants, :[], :size, :each, :include?, :adjacent
    def_delegator :developer, :step

    alias :occupy? :include?

    attr_reader :dna
    attr_reader :occupants
    attr_reader :compass, :developer
    attr_reader :age
    attr_reader :period, :limit

    def initialize(locations=[[0,0]],genome=Genome.default)
      @compass   = Compass.default
      @occupants = locations.map(&method(:occupant_at))

      @dna       = genome.tap do |my|
        @period    = my.growth.cycle
        @rate      = my.growth.rate
        @limit     = my.growth.limit
        @max_age   = my.age_bound
      end

      @age       = 0

      @developer = TerritoryDeveloper.new(self)
    end

    def age! 
      @age = @age + 1 
    end

    def projected_size
      (@rate.additive + size) * @rate.multiplicative 
    end

    def growth
      projected_size - size 
    end

    def occupant_class
      Occupant 
    end

    def occupant_at(point)
      occupant_class.new([point.x, point.y]) 
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
