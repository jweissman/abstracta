module Abstracta
  class Oracle
    def initialize(dimensions: [10,10])
      @grid = Straightedge::Grid.new(dimensions)
      @merge_strategy = :mean
      @births, @deaths = 0, 0
    end

    def predict(colors={}) #, depth: Abstracta.config.speed)
      #return [nil, colors] if depth.zero?
      return ['an empty field remains empty', {}] if colors.empty?

      prediction = colors.clone
      @grid.each do |xy| 
	f = fate(xy,colors)
	next if f.unchanged?
	if f.birth?
	  @births = @births + 1
	  prediction[xy] = merge(neighbors(xy, colors))
	elsif f.death?
	  @deaths = @deaths + 1 
	  prediction.delete(xy) 
	end
      end

      ["Population changed by #{@births-@deaths}", prediction]
    end

    def neighbors(xy, colors)
      @grid.orbit(xy).map { |_xy| colors[_xy] }.compact
    end

    def fate(xy, colors)
      alive = colors.has_key?(xy)
      neighborhood = neighbors(xy,colors)
      foretell_cell_fate alive: alive, surrounding: neighborhood.size
    end

    protected

    def merge(colors)
      if @merge_strategy == :mean
	colors.mean
      elsif @merge_strategy == :smooth
	rgbs = colors.map(&method(:componentize_rgb))
	reds, blues, greens = rgbs.map(&:first), rgbs.map(&:second), rbgs.map(&:third)
	rgb_from_components(reds.mean, blues.mean, greens.mean)
      end
    end

    def rgb_from_components(r,g,b)
      0xFF0000 * r + 0x00FF00 * g +  0x0000FF * b + 0xFF00000000
    end

    def componentize_rgb(color)
      red, green, blue = 0xFF0000 & color, 0x00FF00 & color, 0x0000FF & color

      [red, green, blue]
    end

    def foretell_cell_fate(alive: alive, 
			   surrounding: surrounding)

      principle = Principle.all.detect do |p| 
	p.applies?(alive, surrounding)
      end

      principle ? principle.outcome : Fate.unchanged
    end
  end
end
