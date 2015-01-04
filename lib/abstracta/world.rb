module Abstracta
  class World < Straightedge::Figures::Grid
    extend Forwardable

    def_delegator :current_developer, :projected_world
    def_delegator :occupied, :size
    def_delegator :compass, :orbit

    attr_accessor :status
    attr_reader :colors, :age

    def initialize(dimensions: Abstracta.config.geometry,
		   scale:      Abstracta.config.scale,
		   density:    Abstracta.config.density,
		   territory_count: territory_count,
		   territories:     territories,
		   colors:          colors,
		   status:     "Initializing, please wait")

      @age             = 0

      @dimensions      = dimensions
      @scale           = scale 
      @status          = status
      @compass         = compass

      ts = nil
      if colors.nil?
	n = territory_count || [width * height * density, 1.0].max
	ts ||= create_territories(n)
	@colors = paint_territories(ts)
      else
	@colors = colors
      end

      super(dimensions, scale: @scale)
    end

    def colors
      @colors ||= {}
    end

    def oracle
      @oracle ||= Oracle.new(dimensions: @dimensions)
    end

    def step
      @t0 ||= Time.now
      @age = @age + 1
      @births, @deaths, @colors = oracle.predict(colors)
      @status = "#@age (#{Time.now-@t0}ms, #@births born/#@deaths died)"
      @t0 = Time.now
    end
    
    def projected_growth
      territories.sum(&:growth)
    end

    def create_territories(n=1, m=(Abstracta.config.starting_cell_range).to_a.sample)
      seeds = sample(n).map { |seed| [seed] + orbit(seed) }
      seeds.map { |xys| territory_at(xys.sample(m)) }
    end

    def territory_at(xys, color: pick_color)
      Abstracta.new_territory(xys, color: color)
    end

    def pick_color
      # what is all this wibble (we're apparently trying to favor the palette, at least until it runs out...)
       @color_list ||= Straightedge::Colors.all
       @picked_colors ||= []
       c = Straightedge::Colors.hex_value(@color_list.shift || Straightedge::Colors.random)
       @picked_colors << c
       c
    end

    def paint_territories(ts=create_territories)
      cs = {}
      ts.each do |territory|
	territory.each do |c|
	  cs[[c.x, c.y]] = territory.color
	end
      end
      cs
    end

    def territories
      colors.values.uniq.map do |color|
	xys = colors.select do |xy, clr|
	  clr == color
	end.keys

	territory_at(xys, color: color)
      end
    end

    def color_at(xy)
      colors[xy]
    end

    def visible?(xy)
      colors.has_key?(xy)
    end

    def each_cell
      each do |xy| 
        yield cell_at(xy) if visible?(xy)  #occupied?(xy)
      end
    end

    def cell_at(xy)
      Straightedge::Figures::Quadrilateral.new(color: color_at(xy), dimensions: [@scale, @scale], location: to_pixels(xy))
    end


    def occupied
      colors.keys
    end
  end
end
