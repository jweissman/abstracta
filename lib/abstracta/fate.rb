module Abstracta
  class Fate
    YES       = :it_is_decidedly_so
    NO        = :very_doubtful
    UNCERTAIN = :ask_again_later

    BIRTH     = :signs_point_to_yes
    DEATH     = :outlook_not_so_good 
    UNCHANGED = :nothing_new_under_the_sun
    
    def initialize(outcome)
      @outcome = outcome
    end

    def birth?;     @outcome == BIRTH     end
    def death?;     @outcome == DEATH     end
    def unchanged?; @outcome == UNCHANGED end
    def uncertain?; @outcome == UNCERTAIN end
    def positive?;  @outcome == YES       end
    def negative?;  @outcome == NO        end

    def to_s; @outcome.to_s.gsub('_', ' ').upcase + '!' end

    class << self
      %w[ unchanged uncertain yes no birth death ].each do |fate|
	define_method(fate) { Fate.new(const_get(fate.to_s.upcase)) }
      end
    end
  end
end


