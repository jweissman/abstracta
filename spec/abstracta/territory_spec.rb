require 'spec_helper'
require 'abstracta'
include Abstracta

describe Territory do

  subject { Territory.new([[0,0]]) }

  it 'should have dna' do
    expect(subject.dna).to be_a Genome
  end

  context "#step" do
    it "should age occupants" do
      expect { subject.step }.to change { subject.first.age }.by 1
    end

    it "should grow total size" do
      expect { subject.step([[0,1]]) }.to change { subject.size }.by(1)
    end

    it 'should generate occupants with valid positions' do
      10.times { subject.step }
      subject.occupants.each do |occupant|
	expect(occupant.x).to be_an(Integer)
	expect(occupant.y).to be_an(Integer)
      end
    end
    
    it "should be safe to repeat many times" do
      expect { 100.times { subject.step }}.not_to raise_error
    end
  end
end

