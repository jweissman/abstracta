module Abstracta
  class World
    attr_reader :field, :territories

    def initialize(opts={})
      @age = 0
      @height, @width = opts.delete(:height) { 100 }, opts.delete(:width) { 100 }
      @density = opts.delete(:density) { 0.02 }
      @territory_count = opts.delete(:territory_count) { @width * @height * @density }

      @grid = Grid.new(@width, @height)
      @territories = create_territories(@territory_count)
    end

    def occupants
      @territories.map(&:occupants).flatten(1)
    end

    def create_territories(n=1)
      Array.new(n) { Territory.generate }
      
      #@field.to_a.sample(n).map do |x,y|
      #  [x,y]
      #  #Territory.new(self,[Occupant.new(x,y)])
      #end
    end

    def update_territories
      @age = @age + 1
      @territories.each(&:step)
      #@raw_territories.map! do |occupants| 
      #
      #  radius = @dna[@raw_territories.index(occupants)].growth_radius
      #  targets = @occupants.map(&:location).map {|p| @compass.project(p)} #.adjacent_spaces(occupants, radius)
      #  occupants + targets.sample
      #end
    end

    #def territories
    #end

    def step
      update_territories
      #territories.parallel_each(&:step)
    end

    def available?(position)
      !occupants.any? { |p| p == position }
    end

    def available
      @grid.select { |p| available?(p) }
    end
  end
end

#
