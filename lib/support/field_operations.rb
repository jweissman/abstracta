module Abstracta
  module Support
    #
    # Overwrite self#grid in the host object to make use of field ops 
    #
    #module FieldOperations
    #  def included(base)
    #    base.include(InstanceMethods)
    #    base.extend(ClassMethods)
    #  end

    #  module InstanceMethods
    #    def compass
    #      @compass ||= Compass.new
    #    end

    #    def adjacent_positions_to(p)
    #      @compass.project(p)
    #    end
    #  end

    #  module ClassMethods

    #    protected

    #    def self.delta_x(dir)
    #      return 0 unless [EAST, WEST].include?(dir)
    #      dir == WEST ? -1 : 1
    #    end

    #    def self.delta_y(dir)
    #      return 0 unless [NORTH, SOUTH].include?(dir)
    #      dir == NORTH ? -1 : 1
    #    end

    #    def self.translate(pos,dir)
    #      [pos[0] + delta_x(dir), pos[1] + delta_y(dir)]
    #    end
    #  end
    #end
  end
end
