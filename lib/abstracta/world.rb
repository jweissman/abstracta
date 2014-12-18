module Abstracta
  class World
    extend Forwardable
    attr_reader :age, :grid, :territories, :explorer
    def_delegators :explorer, :grid, :available
    def_delegators :grid, :width, :height

    def initialize(geometry=[100,100], opts={})
      @explorer = Explorer.new(geometry)

      @density = opts.delete(:density) { 0.02 }
      @territory_count = opts.delete(:territory_count) { width * height * @density }
      @territories = []
      @territories = create_territories(@territory_count)
      @age = 0
    end

    def step
      update_territories
    end

    # pick n territorities of size m
    def territory_class; Territory end
    def create_territories(n=1,m=1)
      as = available.sample(m*n)
      Array.new(n) { territory_class.new(as.shift(m)) }
    end

    def update_territories
      @age = @age + 1
      @territories.each do |territory|
	#neighbors = @territories - [territory] #.to_a
	#available_targets = available(territory,neighbors) #@territories-territory.to_a)
	#binding.pry
	territory.step(available) #_targets)
      end
    end
  end
end

#
