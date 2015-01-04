module Abstracta
  include Mini::Config
  configure do |abstracta|
    abstracta.scale = 50
    abstracta.density = 0.125
    abstracta.geometry = [100,100]
    abstracta.speed = 1

    # evolutionary probabilities (note these will mess tests up -- maybe a good candidate for over-riding in tests?)
    # 				 ensures determinacy i mean -- note we could get around this with... seeds... but not sure that's really better
    # 				 at least in this case
    # 				 
    abstracta.reproduction = 0.5 
    abstracta.replication  = 0.125
    abstracta.sudden_death = 0.0125

    # loneliness/starvation limits
    abstracta.starvation = 8
    abstracta.loneliness = 2

    abstracta.starting_cell_range = 2..9
  end

  class << self
    %w[ territory occupant ].each do |elem|
      define_method("new_#{elem}") do |*args| 
	Abstracta.config.send("#{elem}_class").new(*args) 
      end
    end
  end
end

