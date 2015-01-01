require 'pry'
require 'ostruct'
require 'straightedge'

require 'abstracta/version'
require 'abstracta/config'
require 'abstracta/developer'
require 'abstracta/entity'

require 'abstracta/occupant'
require 'abstracta/territory'
require 'abstracta/genome'
require 'abstracta/world'
require 'abstracta/game_master'
require 'abstracta/extend/range'

Straightedge.config.agent_class = Abstracta::GameMaster
Abstracta.config.territory_class = Abstracta::Territory
Abstracta.config.occupant_class = Abstracta::Occupant
