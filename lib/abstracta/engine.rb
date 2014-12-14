module Abstracta
  class Engine
    extend Forwardable
    attr_reader :worlds

    def initialize
      world_count = 1
      @worlds = Array.new(world_count) { World.new }
    end

    def step; @worlds.map(&:step) end
  end
end
