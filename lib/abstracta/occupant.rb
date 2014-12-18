module Abstracta
  class Occupant
    extend Forwardable
    attr_reader :age, :alive, :color, :dna
    attr_reader :location
    def_delegators :location, :zip, :x, :y

    def initialize(location=[0,0],color=:white,alive=true)
      @location = location
      @color    = color
      @alive    = alive
      @age      = 0
      @size     = 1
    end

    def position; [@x,@y] end

    def step
      @age = @age + 1
    end
  end
end
