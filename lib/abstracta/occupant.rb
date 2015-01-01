module Abstracta
  class Occupant
    include Entity
    extend Forwardable

    attr_reader :location
    def_delegators :location, :x, :y

    attr_reader :territory, :world
    attr_reader :max_age

    def initialize(location=[0,0], color: :white, 
		                   territory: nil, 
				   world: nil)
      @color     = color
      @location  = location
      @territory = territory
      @world     = world
    end


    def die!
      @territory.occupants.delete_if { |o| o.location == @location }
    end

    #def step
    #  @age = @age + 1
    #end
  end
end
