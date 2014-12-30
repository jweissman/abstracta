require 'ostruct'
require 'straightedge'

require 'abstracta/version'
require 'abstracta/config'
require 'abstracta/occupant'
require 'abstracta/territory'
require 'abstracta/genome'
require 'abstracta/world'
require 'abstracta/developer'
require 'abstracta/game_master'
require 'abstracta/extend/range'

Straightedge.config.agent_class = Abstracta::GameMaster
