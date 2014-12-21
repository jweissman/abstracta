module Abstracta
  class Engine
    extend Forwardable
    attr_reader :worlds, :running

    def initialize(steps: 0, active: false, world_count: 3, &blk)
      @worlds = Array.new(world_count) { World.new }
      @running = active
      puts "--- engine constructed!"
      step(steps,&blk)
    end

    def step(n=1,&blk)
      print '.'
      n.times do 
	@worlds.map(&:step)
	blk.call(self) if block_given?
      end
      self 
    end

    def turn(&blk)
      @running = true
      Thread.new do
	while @running 
	  step(&blk)
	end
      end
    end

    def halt; @running = false end

    def self.boot(opts={},&blk)
      new(opts,&blk)
    end
  end
end
