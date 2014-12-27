#
# interesting that i am tempted to multiclass this
# both with local developer and straightedge director
#
# maybe these should be mixin-modules
#
module Abstracta
  class GameMaster < Straightedge::Director
    def current_scene
      {
	[0, 0]  => world,
	[10,10] => "hello player"
      }
    end

    def cell_size
      @cell_size ||= 20
    end

    def world
      @world ||= Abstracta::World.new([@width/cell_size, @height/cell_size], scale: cell_size) #, scale: 10)
    end

    def orchestrate
      world.step
    end

    #def click(x,y)
    #  @world
    #end
  end
end
