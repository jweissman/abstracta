module Abstracta
  class Genome < OpenStruct
    def self.default
      OpenStruct.new(
	#growth_cycle: (2..10).sample,
	#growth_limit: (4..20).sample,
	#growth_radius: (1..4).sample,
	#growth_rate: (15..100).sample / 10.0,

	growth: OpenStruct.new(
	  cycle:  (2..20).sample,
	  limit:  (40..200).sample,
	  radius: (1..4).sample,
	  rate:   (20..40).sample / 10.0,
        )

	# TODO make these do something!
	#age_bound: 100,
	#influence_radius: 10,
	#sterile: false, 
	#sticky: false,
	#vision_radius: 100,
        #mobile: true, 
      )
    end
  end
end
