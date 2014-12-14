module Abstracta
  class Genome < BinData::Record
    bit1 :mobile
    bit1 :sticky
    bit1 :armored
    bit1 :sterile
     
    int8 :growth_cycle
    int8 :growth_radius
    int8 :growth_limit
    int8 :influence_radius
    int8 :vision_radius

    def self.default
      new(
	growth_cycle: 1,
	growth_limit: 10,
	growth_radius: 1,
	influence_radius: 10,
	sterile: false, 
	sticky: false,
	vision_radius: 100,
        mobile: true, 
      )
    end
  end
end
