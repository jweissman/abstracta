require 'spec_helper'
require 'abstracta'
include Abstracta

describe Territory do
  subject { Territory.new([[0,0]]) }

  it 'should have dna' do
    expect(subject.dna).to be_a OpenStruct
  end

  # the implementation of this really closely maps to compasses so when
  # we switch roses it all breaks -- very flaky
  #describe "#adjacent" do
  #  context "from origin" do
  #    it 'should project nearby squares' do
  #      expect(subject.adjacent).to eql([[0, -1], [0, 1], [1, 0], [-1, 0]])
  #    end
  #  end
  #  
  #  context "with multiple occupants" do
  #    before { subject.step([[0,1]]) }
  #    it 'should compute nearby, non-overlapping squares' do
  #      expect(subject.adjacent).to eql([[0, -1], [0, 1], [1, 0], [-1, 0], [0, 0], [0, 2], [1, 1], [-1, 1]]) #[[1,0]])
  #    end

  #    # i.e.:
  #    # |-|-|-|-|-|-|-|-|-|-|-|
  #    # |-|-|-| * | * |-|-|-|-|
  #    # |-|-|-|-|-|-|-|-|-|-|-|
  #    # |-| * |   |   | * |-|-|
  #    # |-|-|-|-|-|-|-|-|-|-|-|
  #    # |-|-|-| * | * |-|-|-|-|
  #    # |-|-|-|-|-|-|-|-|-|-|-|
  #  end
  #end

  describe "#step" do
    it "should age occupants" do
      expect { subject.step }.to change { subject.first.age }.by 1
    end

    let(:cycle) { subject.growth.cycle }

    it "should grow total size" do
      expect { cycle.times { subject.step } }.to change { subject.size }.by(subject.projected_growth.to_i)
    end

    context "longterm growth behaviors" do
      before { cycle.times { subject.step }} #.not_to raise_error }

      it 'should generate occupants with valid positions' do
	subject.occupants.each do |occupant|
	  expect(occupant.x).to be_an(Integer)
	  expect(occupant.y).to be_an(Integer)
	end
      end

      it "should grow a little bit" do
	expect(subject.size).to be > 1
      end

      it "should not grow too much" do
	expect(subject.size).not_to be > subject.growth.limit
      end
    end
  end

  #context "#grow" do
  #end
end

