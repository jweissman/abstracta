require 'spec_helper'
require 'abstracta'

include Abstracta

describe TerritoryDeveloper do
  
  let(:territory) { Territory.new }
  subject { TerritoryDeveloper.new(territory) }

  describe "#step" do
    it "should age occupants" do
      expect { subject.step }.to change { subject.first.age }.by 1
    end

    #it "should grow to a specific location" do
    #  expect { subject.step([[0,1]]) }.to change { subject.size }.by(1)
    #end

    let(:cycle) { subject.period }

    it "should grow total size" do
      expect { cycle.times { subject.step } }.to change { subject.size }.by(subject.growth.to_i)
    end

    context "longterm growth behaviors" do
      before { cycle.times { subject.step }}

      it 'should generate occupants with valid positions' do
	subject.each do |occupant|
	  expect(occupant.x).to be_an(Integer)
	  expect(occupant.y).to be_an(Integer)
	end
      end

      it "should grow a little bit" do
	expect(subject.size).to be > 1
      end

      it "should not grow too much" do
	expect(subject.size).not_to be > subject.limit
      end
    end
  end
end

