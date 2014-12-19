require 'ostruct'
module Abstracta
  class Genome < OpenStruct
    def self.default
      OpenStruct.new(
	growth_cycle: 1,
	growth_limit: 10,
	growth_radius: 1,
	growth_rate: 1.4,
	influence_radius: 10,
	sterile: false, 
	sticky: false,
	vision_radius: 100,
        mobile: true, 
      )
    end
  end
end
