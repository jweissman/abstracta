module Abstracta
  class World < Straightedge::Figures::Grid
    include Entity
    extend Forwardable

    def_delegator :current_developer, :projected_world
    def_delegator :occupied, :size

    attr_accessor :status
    attr_reader :colors

    def initialize(dimensions: Abstracta.config.geometry,
		   scale:      Abstracta.config.scale,
		   density:    Abstracta.config.density,
		   territory_count:      nil,
		   territories: nil,
		   colors: colors,
		   status:     "Initializing, please wait")
      @dimensions      = dimensions

      @scale           = scale 
      @status          = status
      if colors
	puts "--- using provided colors" 
      end

      @colors = colors || begin
        n = territory_count || width * height * density
        puts "--- creating #{n} territories"
        territories ||= create_territories(n)

        paint_territories(territories)
      end

      super(dimensions, scale: @scale)
    end

    def projected_growth
      territories.sum(&:growth)
    end

    def create_territories(n)
      ts = []
      seeds = sample(n)
      seeds.each do |seed|
	print '.'
	starting_cells = [seed] # + project(seed).sample(1)
	ts << territory_at(starting_cells)
      end
      ts
    end

    def paint_territories(ts)
      cs = {}
      ts.each do |territory|
	territory.occupants.map(&:location).each do |xy|
	  cs[xy] = territory.color
	end
      end
      cs
    end

    def clear(xy=nil)
      if xy == nil
	@colors = {}
      else
	@colors.delete(xy) #[xy] = nil
      end
    end

    def pick_color
      @unpicked_colors ||= Straightedge::Colors.all
      @unpicked_colors.shift
    end

    def paint(xy, color: pick_color) # Straightedge::Colors.pick)
      @colors ||= {}
      #puts "--- painting #{xy} '#{color}'"
      @colors[xy] = color
    end

    def territories
      @colors.values.uniq.map do |color|
	xys = @colors.select do |xy, clr| #invert[color]
	  clr == color
	end.keys

	territory_at(xys, color: color)
      end
    end

    def visible?(xy)
      occupied?(xy) #.include?(xy) 
    end

    def color_at(xy)
      @colors[xy]
    end

    def each_cell
      super do |xy|
	yield xy if visible?(xy)
      end
    end

    #def each_cell
    #  each do |xy| 
    #    cell = cell_at xy
    #    yield cell if cell && occupied?(xy) # && color_at(xy)
    #  end
    #end

    #def colors_around(xy)
    #  project(xy).map { |_xy| color_at(_xy) }.compact
    #end

    def territory_at(xys, color: pick_color) #Straightedge::Colors.pick)
      Abstracta.new_territory(xys, color: color)
    end

    def occupied
      @colors ||= {}
      @colors.keys
    end

    def occupied?(xy)
      occupied.include?(xy)
    end

    def surrounding(xy)
      project(xy).map(&method(:detect_occupant_at)).compact
    end
  end
end
