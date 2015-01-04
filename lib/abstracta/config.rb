module Abstracta
  include Mini::Config
  configure do |abstracta|
    abstracta.scale = 30
    abstracta.density = 0.00125
    abstracta.geometry = [100,100]
    abstracta.speed = 1

    # evolutionary probabilities (note these will mess tests up -- maybe a good candidate for over-riding in tests?)
    # 				 ensures determinacy i mean -- note we could get around this with... seeds... but not sure that's really better
    # 				 at least in this case
    # 				 
    abstracta.reproduction = 0.25 
    abstracta.replication  = 0.025

    # loneliness/starvation limits
    abstracta.decay = 0.025
    abstracta.starvation = 6
    abstracta.loneliness = 4

    abstracta.starting_cell_range = 3..7
  end

  class << self
    %w[ territory occupant ].each do |elem|
      define_method("new_#{elem}") do |*args| 
	Abstracta.config.send("#{elem}_class").new(*args) 
      end
    end
  end
end

