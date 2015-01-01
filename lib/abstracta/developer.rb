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
      #puts "#{self.class}#step_children(begin)"
      collection.map do |child|
	#puts "#{self.class}#step_children -- child: #{child}"
	child.step # (parent: entity) #(*args)
      end #(&:step)
      #puts "#{self.class}#step_children(end)"
    end

    def step(*args)
      #puts "#{self.class}#step(begin)"
      tick
      #puts "#{self.class}#step -- step_children"
      step_children #(*args)
      develop(*args)
      #puts "#{self.class}#step(end)"
    end

    def develop(*args); end

    def self.for(entity)
      #puts "--- dev for #{entity}"
      { 
	World => WorldDeveloper, Territory => TerritoryDeveloper, Occupant => OccupantDeveloper 
      }[entity.class].new(entity)
    end
  end

  class WorldDeveloper < Developer
    def_delegators :world, :age, :size, :occupied?, :clip, :each, :surrounding,
			   :cell_at, :compute_occupied, :occupant_at, :projected_growth

    def world; @entity end
    def collection; world.territories end

    def develop(*ignored)
      t0 = Time.now
      puts "=== WorldDeveloper#develop !!!"
      created = {}
      puts "--- considering world of dimensions #{world.width} x #{world.height}"
      
      each do |xy|
	s = surrounding(xy)
	if !occupied?(xy)
	  if s.count >= 1 && s.count <= 8 && rand < 0.3
	    t = s.sample.territory
	    created[t] ||= []
	    if created[t].count < t.growth
	      created[t] << xy
	    end
	  end
	else
	  lonely, overcrowded = 2, 7
	  if s.count <= lonely || s.count >= overcrowded
	    occupant_at(xy).die! 
	  end
	end
      end

      created.each { |t, locations| locations.each { |o| t.occupy!(o) } }
      compute_occupied

      world.status = "growing (step processed in #{Time.now-t0})"
    end
  end

  class TerritoryDeveloper < Developer
    #def_delegators :territory, :age, :size, :period, :limit, :each, # :first,
    #  :occupy!, :adjacent, :growth, :cull!

    def territory; @entity end
    def collection; territory.occupants end
  end

  class OccupantDeveloper < Developer
    def occupant; @entity end
  end
end
