require 'coco'
require 'rspec'
require 'rspec/its'
require 'pry'

require 'profile' if ENV["PROFILE"] == "1"

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
