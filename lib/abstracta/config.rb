module Abstracta
  include Mini::Config
  configure do |abstracta|
    abstracta.scale = 10
    abstracta.density = 0.125
    abstracta.geometry = [10,10]
  end

  class << self
    %w[ territory occupant ].each do |elem|
      define_method("new_#{elem}") do |*args| 
	Abstracta.config.send("#{elem}_class").new(*args) 
      end
    end
  end
end

