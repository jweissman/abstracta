require 'rspec/core'
require 'profile' if ENV["PROFILE"] == "1"
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'abstracta'

# just for determinisms sake
Abstracta.configure do |test|
  test.speed = 1
  test.geometry = [ 1_000, 1_000 ]
  test.density  = 0.25

  test.reproduction = 1.0
  test.replication  = 1.0
  test.sudden_death = 0.0

  test.starvation   = 8
  test.loneliness   = 2
  
  test.starting_cell_range = 2..2
end
