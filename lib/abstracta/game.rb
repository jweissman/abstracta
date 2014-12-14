#require 'abstracta'

module Abstracta
  class Game
    attr_accessor :field, :organisms
    def initialize
      puts "=== new game!"
      bootstrap
    end

    def bootstrap
      @organisms = []
      @field = Field.new(10,10) do |x,y|
	#return unless rand < 0.05
	puts "--- creating organism at #{x}, #{y}"
	organism = Organism.new(@field, x, y)
	@organisms << organism
	organism
      end
    end

    #def step
    #  @organisms.each(&:develop)
    #end
  end
end

#Abstracta::Game.new.play if __FILE__ == $0
