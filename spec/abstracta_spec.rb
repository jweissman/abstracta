require 'spec_helper'
require 'abstracta'
include Abstracta

describe Abstracta do
  describe "constants" do
    it "should have a VERSION constant" do
      expect(subject.version).to eql("v0.1.0-prealpha \"aqua-prism\", (c) 2014 Joseph Weissman <jweissman1986@gmail.com>")
    end

    it "should bootstrap the sim engine" do
      # should call a hook
      some_receiver = double(foo: true)
      expect(some_receiver).to receive(:foo).with(kind_of(World))
      Abstracta.bootstrap!(steps: 1, world_count: 1) do |sim|
	world = sim.worlds.first
	some_receiver.foo(world)
      end
    end
  end
end
