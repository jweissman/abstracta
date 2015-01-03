module Abstracta
  class GameMaster < Straightedge::Director
    def current_scene
      {
	[0, 0]  => world,
	[10,10] => "abstracta v#{Abstracta::VERSION}",
	[10,100] => world.status
      }
    end

    def prepare_stage(dimensions)
      @physical_dimensions = dimensions
    end

    def scale
      Abstracta.config.scale
    end

    def logical_geometry
      @logical_geometry ||= [@physical_dimensions.x / scale, @physical_dimensions.y / scale]
    end

    def world
      @world ||= Abstracta::World.new(dimensions: logical_geometry, scale: scale)
    end

    def orchestrate
      @t0 ||= Time.now
      sz = world.size
      world.step
      puts "--- grew by #{world.size-sz}, step in #{Time.now-@t0}"
      @t0 = Time.now
    end

    def click(x,y)
      warn "abstracta::GameMaster received click at #{x}, #{y} (#{x/scale}, #{y/scale})"
    end
  end
end
