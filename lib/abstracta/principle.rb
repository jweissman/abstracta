module Abstracta
  class Principle
    attr_reader :outcome

    def initialize(name, outcome: Fate.unchanged,
		   living:  true,
		   random: 1.0,
		   range: 2..4)
      @name    = name
      @outcome = outcome
      @living  = living
      @random  = random
      @range   = range
    end

    def applies?(living, nearby)
      @applies ||= {}
      @applies[[living,nearby]] ||= @living == living && @range.include?(nearby) 

      @applies[[living,nearby]] && roll_dice
    end

    def roll_dice; rand < @random end

    def self.life(name='', range: 2..9, random: 1.0)
      Principle.new(name, 
        outcome: Fate.birth, 
	range: range, 
	random: random, 
	living: false)
    end

    def self.death(name='', range: 3..7, random: 1.0)
      Principle.new(name,
		    outcome: Fate.death,
		    range: range,
		    random: random,
		    living: true)
    end

    def self.reproduction
      @reproduction ||= life(:reproduction, 
	   random: Abstracta.config.reproduction, range: 2..4)
    end

    def self.replication
      @replication ||= life(:replication, 
	  random: Abstracta.config.replication, range: 1..1)
    end

    def self.starvation
      @starving ||= death :starvation, range: Abstracta.config.starvation..10 
     # ..(Abstracta.config.loneliness))
    end

    def self.loneliness
      @lonely ||= death :loneliness, range: 0..Abstracta.config.loneliness
    end

    def self.all
      @book ||= [ reproduction, replication, starvation, loneliness ]
    end
  end
end
