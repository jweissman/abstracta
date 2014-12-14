module Abstracta
  class Occupant
    attr_reader :age, :alive, :color, :dna, :x, :y

    def initialize(x=0,y=0,color=:white,alive=true)
      @x = x
      @y = y
      @color = color
      @alive = alive
      @age = 0
      @size = 1
    end

    def position; [@x,@y] end

    def step
      @age = @age + 1
    end

    def self.generate(world=nil)
      return new unless world
      new(world.available.sample)
    end
  end
end
