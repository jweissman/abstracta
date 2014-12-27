require 'ostruct'
require 'straightedge'

require 'abstracta/version'
require 'abstracta/occupant'
require 'abstracta/territory'
require 'abstracta/genome'
require 'abstracta/world'
require 'abstracta/developer'
require 'abstracta/game_master'
require 'abstracta/extend/range'

#module Abstracta
#  include Straightedge
#  include Straightedge::Figures
#  include Straightedge::Toolkit
#end

module Straightedge
  def self.default_agent_class
    Abstracta::GameMaster
  end
end

