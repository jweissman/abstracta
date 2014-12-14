module Abstracta
  class World
    attr_reader :age, :field, :territories

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
    end

    def update_territories
      @age = @age + 1
      @territories.each(&:step)
    end

    def step
      update_territories
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
