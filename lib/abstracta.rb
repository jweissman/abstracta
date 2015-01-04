require 'ostruct'
require 'straightedge'
require 'pry'

require 'abstracta/version'
require 'abstracta/config'
#require 'abstracta/developer'
#require 'abstracta/entity'

require 'abstracta/occupant'
require 'abstracta/territory'
require 'abstracta/genome'
require 'abstracta/world'

require 'abstracta/fate'
require 'abstracta/principle'
require 'abstracta/oracle'

require 'abstracta/game_master'
require 'abstracta/extend/range'


Straightedge.config.agent_class = Abstracta::GameMaster
Abstracta.config.territory_class = Abstracta::Territory
Abstracta.config.occupant_class = Abstracta::Occupant
