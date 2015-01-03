module Abstracta
  class Oracle
    def initialize(dimensions: [10,10])
      @grid = Straightedge::Grid.new(dimensions)
    end

    def neighbors(xy, colors)
      @grid.orbit(xy).map { |_xy| colors[_xy] }.compact
    end

    def predict(colors={})
      return ['an empty field remains empty', {}] if colors.empty?

      @births, @deaths = 0, 0
      prediction = colors.clone
      @grid.each do |xy| 
	alive = colors.has_key?(xy)
	neighborhood = neighbors(xy,colors) #@grid.orbit(xy).select { |_xy| colors.has_key?(_xy) }
	fate = foretell_cell_fate alive: alive, surrounding: neighborhood.size
	next if fate.unchanged?
	prediction = predict_xy(xy, fate, colors, prediction)
      end
      @delta = @births - @deaths
      #puts "   --------> The total population will change by #@delta."
      #puts "             (There will be #@births born and #@deaths dead.)"

      remarks = "Population changed by #@delta"
      #puts "     -------> #{remarks}"

      [remarks, prediction] #
    end

    def predict_xy(xy, fate, colors, predicted_colors)
      #puts " ---> predicting #{xy}"
      #puts " * fate: #{fate}"
      if fate.birth?
	neighbors = neighbors(xy, colors) # @grid.orbit(xy).map { |_xy| colors[xy] }.compact
	#binding.pry
	predicted_colors[xy] = # averaged_color
	  neighbors.mean
	@births = @births + 1
      elsif fate.death?
	predicted_colors.delete(xy) 
	@deaths = @deaths + 1 
      end
      predicted_colors
    end

    protected

    #def create_rule(outcome, living: true, neighbors: {}, random: 1.0)
    #  @rules ||= []
    #  @rules << OpenStruct.new(alive: living, around: neighbors.merge(gt: 0, lt: 9), random: random)
    #end

    #def apply_rules(alive, surrounding)
    #  @rules.each do |rule|

    #  end
    #end

    #def build_basic_rules
    #  # replication and reproduction
    #  create_rule Fate.birth, living: false, neighbors: { gt: 1 }, random: Abstracta.config.replication)
    #  create_rule Fate.birth, living: false, neighbors: { gt: 2 }, random: Abstracta.config.reproduction)

    #  # starvation and loneliness
    #  create_rule Fate.death, living: true, neighbors: { lt: Abstracta.config.starvation }
    #  create_rule Fate.death, living: true, neighbors: { gt: Abstracta.config.loneliness }

    #  # doooooooom
    #  create_rule Fate.death, living: true, random: Abstracta.config.sudden_death 
    #end

    def foretell_cell_fate(alive: alive, surrounding: surrounding, 
			   reproduction:  Abstracta.config.reproduction,
			   replication:   Abstracta.config.replication,
			   sudden_death:  Abstracta.config.sudden_death,
			   starvation:    Abstracta.config.starvation,
			   loneliness:    Abstracta.config.loneliness)

      s = surrounding

      reproduce = s >= 2 && rand < reproduction
      replicate = s >= 1 && rand < replication

      starve    = s >= starvation
      lonely    = s <= loneliness
      doomed    = rand < sudden_death

      if !alive && (reproduce || replicate)
	Fate.birth
      elsif alive && (starve || lonely || doomed)
	Fate.death
      else
	Fate.unchanged
      end
    end
  end
end
