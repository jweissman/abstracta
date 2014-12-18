module Abstracta
  class Occupant
    extend Forwardable
    attr_reader :age
    attr_reader :location
    def_delegators :location, :zip, :x, :y

    def initialize(location=[0,0])
      @location = location
      @age      = 0
      @size     = 1
    end

    def position; [@x,@y] end

    def step
      @age = @age + 1
    end
  end
end
