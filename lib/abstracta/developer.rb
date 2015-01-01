module Abstracta
  class Developer
    extend Forwardable

    attr_reader :entity
    def_delegator :entity, :age

    def initialize(entity)
      @entity = entity
    end

    def collection; [] end

    def tick
      @entity.age!
    end

    def step_children
      collection.compact.map { |child| child.step }
    end

    def step(*args)
      tick
      step_children
      develop(*args)
    end

    def develop(*args); end

    def self.for(entity)
      { 
	World => WorldDeveloper, Territory => TerritoryDeveloper, Occupant => OccupantDeveloper 
      }[entity.class].new(entity)
    end
  end

  # 
  # really this becomes a lot simpler
  # if we completely ignore territories
  # i have been resisting this impulse
  # but maybe it's right -- maybe territories *are* 
  # a higher-order notion...
  #
  # in other words what if it's just about
  # *colors* -- eventually *dna*
  #

  class WorldDeveloper < Developer

    def world; @entity end
    def collection; world.territories end

    def foretell_cell_fate(dead: dead, surrounding: surrounding, replication: 0.2, genesis: 0.01)
      s = surrounding
      return :born  if dead && ((s >= 2 && rand < replication) || (s >= 1 && rand < genesis))
      return :dying if !dead && s <= 1 || s >= 8
      :unchanged
    end

    def predict_at(xy, w0) #, w1)
      currently_dead        = !w0.occupied?(xy)
      projected_xy          = Straightedge::Compass.default.project(xy)

      surrounding_occupied  = projected_xy.select { |l| w0.occupied?(l) }
      surrounding_count     = surrounding_occupied.size

      foretell_cell_fate dead: currently_dead, surrounding: surrounding_count
    end

    def project_colors
      projected_world        = world.clone
      all_adj = world.territories.map(&:adjacent).flatten(1).uniq
      all_adj.each do |xy| 
	case predict_at(xy, world) #, projected_world) 
	when :born  then 
	  projected_world.paint(xy) #, world.colors_around(xy).mean)
	when :dying then projected_world.clear(xy)
	end
      end
      projected_world.colors
    end

    def develop(*ignored)
      t0 = Time.now
      sz = world.size

      new_colors = project_colors

      @entity = World.new(dimensions: world.dimensions, 
			  colors: new_colors)

      world.status = "grew by #{world.size-sz}; step processed in #{Time.now-t0}"
      puts world.status
    end
  end

  class TerritoryDeveloper < Developer
    def territory; @entity end
    def collection; territory.occupants end
  end

  class OccupantDeveloper < Developer
    def occupant; @entity end
  end
end
