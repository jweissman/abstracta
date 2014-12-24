require 'ostruct'

require 'straightedge'

require 'abstracta/version'
require 'abstracta/occupant'
require 'abstracta/territory'
require 'abstracta/genome'
require 'abstracta/world'
require 'abstracta/developer'
require 'abstracta/extend/range'

module Abstracta
  include Straightedge
  def self.bootstrap!(opts={},&blk)
    Engine.boot(opts,&blk)
  end
end
