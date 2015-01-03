module Abstracta
  class Occupant
    include Straightedge::Aspects::Colorable
    extend Forwardable

    attr_reader :location
    attr_reader :age
    attr_reader :territory, :world

    def_delegators :location, :x, :y

    def initialize(location=[0,0], color: :white, 
		                   territory: nil, 
				   world: nil)
      @color     = color
      @location  = location
      @territory = territory
      @world     = world
      @age       = 0
    end

    def step; @age = @age + 1 end
  end
end
