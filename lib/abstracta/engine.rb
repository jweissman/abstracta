
module Abstracta
  class Engine
    extend Forwardable
    attr_reader :worlds

    def initialize
      world_count = 1
      @worlds = Array.new(world_count) { World.new }
      #@log = Logger.new
      #@worlds.map(&:events).each { |stream| stream.on_value(&:react) }
    end

    def step; @worlds.map(&:step) end
    #def react(event)
    #  puts ">>> Event: #{event}"
    #  @log.info event
    #end
  end
end
