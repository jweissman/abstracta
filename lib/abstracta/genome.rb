
module Abstracta
  class Genome < BinData::Record
    bit1 :mobile
    bit1 :sterile
    bit1 :sticky
    bit1 :armored
    bit1 :acidic
    bit1 :fiber
    bit1 :channel
    bit1 :worm

    bit4 :growth_cycle
    bit4 :growth_radius
    bit4 :growth_limit

    bit8 :influence_radius
    bit8 :vision_radius


    # packed structure of suborganisms...?
    #

    def self.default
      #default_options = {:influence_radius => 30, :vision_radius => 100}
      Genome.new( mobile: 1, sterile: 0, growth_cycle: 1, growth_radius: 2)
    end
  end
end
