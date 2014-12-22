require 'parallel'
require 'ostruct'

require 'abstracta/version'
require 'abstracta/rose'
require 'abstracta/compass'
require 'abstracta/grid'
require 'abstracta/occupant'
require 'abstracta/territory'
require 'abstracta/genome'
require 'abstracta/world'

require 'active_support/core_ext/array'
require 'abstracta/extend/array'
require 'abstracta/extend/range'

module Abstracta
  def self.bootstrap!(opts={},&blk)
    Engine.boot(opts,&blk)
  end
end
