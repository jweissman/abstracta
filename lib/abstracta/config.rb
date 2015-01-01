module Abstracta
  include Mini::Config
  configure do |abstracta|
    abstracta.scale = 50
    abstracta.density = 0.125
    abstracta.geometry = [20,20]
  end

  class << self
    %w[ territory occupant ].each do |elem|
      define_method("new_#{elem}") do |*args| 
	Abstracta.config.send("#{elem}_class").new(*args) 
      end
    end
  end
end

