require 'rspec/core'
require 'profile' if ENV["PROFILE"] == "1"
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
