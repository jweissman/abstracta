require 'spec_helper'
require 'abstracta'
require 'pry'

include Abstracta

describe WorldDeveloper do
  
  let(:world) { World.new }
  subject { WorldDeveloper.new(world) }

  describe "#step" do
    #it "should age occupants" do
    #  expect { subject.step }.to change { subject.collection.first.age }.by 1
    #end

    let(:cycle) { 1 }# subject.territories.first.period }

    it "should grow total size" do
      expect { subject.step }.to change { subject.world.size }.by(a_value > 0)
      expect { subject.step }.to change { subject.world.size }.by(a_value <= (subject.world.projected_growth.to_i))
    end

    context "longterm growth behaviors" do

      it 'should generate territories with valid positions' do
	cycle.times { subject.step }
	subject.world.each do |territory|
	  expect(territory.x).to be_an(Integer)
	  expect(territory.y).to be_an(Integer)
	end
      end

      it "should grow a little bit" do
	sz = world.size
	cycle.times { subject.step }
	expect(world.size).to be > sz
      end

      #it "should not grow too much" do
      #  expect(subject.size).not_to be > subject.limit
      #end
    end
  end
end

