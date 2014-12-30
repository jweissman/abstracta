module Abstracta
  include Mini::Config
  configure do |abstracta|
    abstracta.scale = 100
    abstracta.density = 0.05
  end

  class << self
    %w[ territory occupant ].each do |elem|
      define_method("new_#{elem}") do |*args| 
	Abstracta.config.send("#{elem}_class").new(*args) 
      end
    end
  end
end

