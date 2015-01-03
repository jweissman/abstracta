module Abstracta
  #class Developer
  #  extend Forwardable

  #  attr_reader :entity
  #  def_delegator :entity, :age

  #  def initialize(entity)
  #    @entity = entity
  #  end

  #  def collection; [] end

  #  def tick
  #    @entity.age!
  #  end

  #  def step_children
  #    collection.compact.map { |child| child.step }
  #  end

  #  def step(*args)
  #    tick
  #    step_children
  #    @entity = develop(*args)
  #  end

  #  def develop(*args); @entity end

  #  def self.for(entity)
  #    { 
  #      World => WorldDeveloper, Territory => TerritoryDeveloper, Occupant => OccupantDeveloper 
  #    }[entity.class].new(entity)
  #  end
  #end

  #class WorldDeveloper < Developer

  #  extend Forwardable
  #  def_delegators :world, :occupied?, :color_at, :project

  #  def world; @entity end
  #  def collection; world.territories end

  #  def foretell_cell_fate(dead: dead, surrounding: surrounding, 
  #      		   replication:  Abstracta.config.replicate,
  #      		   genesis:      Abstracta.config.genesis,
  #      		   sudden_death: Abstracta.config.sudden_death,
  #      		   starvation:   Abstracta.config.starvation,
  #      		   loneliness:   Abstracta.config.loneliness)
  #    s = surrounding
  #    return :born  if dead  && ((s >= 2 && rand < replication)      || (s >= 1 && rand < genesis))
  #    return :dying if !dead && (s <= loneliness || s >= starvation) || (s >= 1 && rand < sudden_death)
  #    :unchanged
  #  end

  #  def surrounding_occupied(xy)
  #    project(xy).select(&method(:occupied?))
  #  end

  #  def surrounding_colors(xy)
  #    (surrounding_occupied(xy).map(&method(:color_at)).compact.map { |c| Straightedge::Colors.hex_value(c) })
  #  end

  #  def foretell_fate_at(xy)
  #    currently_dead        = !occupied?(xy)
  #    surrounding_count     = surrounding_occupied(xy).size
  #    foretell_cell_fate dead: currently_dead, surrounding: surrounding_count
  #  end

  #  def predict_color_at(xy)
  #    case foretell_fate_at xy
  #    when :born then
  #      surrounding_colors(xy).mean
  #    when :dying then 
  #      nil
  #    else
  #      occupied?(xy) ? color_at(xy) : nil
  #    end
  #  end

  #  def predict_colors
  #    predicted_world = world.clone
  #    world.each do |xy| 
  #      color_at_xy = predict_color_at xy
  #      if color_at_xy
  #        predicted_world.paint(xy, color: color_at_xy)
  #      else
  #        predicted_world.clear(xy)
  #      end
  #    end
  #    predicted_world.colors
  #  end

  #  def develop(*ignored)
  #    World.new(dimensions: world.dimensions, 
  #              colors: predict_colors, 
  #              status: "Step #{world.age}",
  #              age: world.age)
  #  end
  #end

  #class TerritoryDeveloper < Developer
  #  def territory; @entity end
  #  def collection; territory.occupants end
  #end

  #class OccupantDeveloper < Developer
  #  def occupant; @entity end
  #end
end
