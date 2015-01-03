module Abstracta
  include Mini::Config
  configure do |abstracta|
    abstracta.scale = 20
    abstracta.density = 0.00125
    abstracta.geometry = [1000,1000]

    # evolutionary probabilities (note these will mess tests up -- maybe a good candidate for over-riding in tests?)
    # 				 ensures determinacy i mean -- note we could get around this with... seeds... but not sure that's really better
    # 				 at least in this case
    # 				 
    abstracta.reproduction = 1.0 #0.32 # 0.88 #0.93
    abstracta.replication  = 0.0 #28 #0.5
    abstracta.sudden_death = 0.0 #25 #0.0125

    # loneliness/starvation limits
    abstracta.starvation = 9
    abstracta.loneliness = 0

    abstracta.starting_cell_range = 4..8
  end

  class << self
    %w[ territory occupant ].each do |elem|
      define_method("new_#{elem}") do |*args| 
	Abstracta.config.send("#{elem}_class").new(*args) 
      end
    end
  end
end

