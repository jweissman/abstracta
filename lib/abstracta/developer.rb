module Abstracta
  class Developer
    extend Forwardable
    def initialize(entity)
      @entity = entity
    end

    def collection; [] end

    def tick
      @entity.age!
    end

    def step(*args)
      tick
      develop(*args)
      collection.map(&:step)
    end
  end

  class WorldDeveloper < Developer
    def world; @entity end
    def collection; world.territories end

    def develop
      # now a no-op...
    end
  end

  class TerritoryDeveloper < Developer
    def_delegators :territory, :age, :size, :period, :limit, :[], :each, :first,
			       :occupy!, :adjacent, :growth, :cull!

    def territory; @entity end
    def collection; territory.occupants end

    def develop(targets: adjacent)
      grow(targets) if growth_indicated?
      cull!
    end

    def growth_indicated?
      in_cycle = age % territory.period == 0
      under_bound = size <= territory.limit
      in_cycle && under_bound
    end

    def grow(targets, n=growth)
      targets.sample(n).map(&method(:occupy!))
    end
  end
end
