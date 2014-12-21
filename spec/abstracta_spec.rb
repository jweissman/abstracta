require 'spec_helper'
require 'abstracta'
include Abstracta

describe Abstracta do
  describe "constants" do
    let(:version) { subject.const_get 'VERSION' }
    it "should have a VERSION constant" do
      expect(version).not_to be_empty
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
