module Abstracta
  class Genome < OpenStruct
    # move into config?
    def self.default
      @default_genome ||= OpenStruct.new(
	age_bound: 10,
	growth: OpenStruct.new(
	  cycle:  1,
	  limit:  100,
	  rate: OpenStruct.new(
	    additive: 2,
	    multiplicative: 1.25
          )
        )
      )
    end
  end
end
