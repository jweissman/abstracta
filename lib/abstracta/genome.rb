module Abstracta
  class Genome < OpenStruct
    def self.default
      @default_genome ||= OpenStruct.new(
	#growth_cycle: (2..10).sample,
	#growth_limit: (4..20).sample,
	#growth_radius: (1..4).sample,
	#growth_rate: (15..100).sample / 10.0,

	growth: OpenStruct.new(
	  cycle:  2, #(2..4).sample,
	  limit:  100, #(20..80).sample,
	  #radius: (1..2).sample,
	  rate:   2, #(1..4).sample #(150..200).sample / 100.0,
        ),

	# TODO make these do something!
	age_bound: 20 #(3..9).sample,
	#influence_radius: 10,
	#sterile: false, 
	#sticky: false,
	#vision_radius: 100,
        #mobile: true, 
      )
    end
  end
end
