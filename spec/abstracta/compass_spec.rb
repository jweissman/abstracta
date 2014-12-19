require 'spec_helper'
require 'abstracta/compass'
include Abstracta

describe Compass do
  let(:origin) { [0,0] }

  it 'should translate points' do
    expect(subject.move([0,1],:north)).to eql(origin)
    expect(subject.move([-1,0],:east)).to eql(origin)
    expect(subject.move(origin, :south)).to eql([0,1])
  end

  it 'should project points' do
    expect(subject.project(origin)).to eql(subject.class.simple_rose.values)
  end

  it 'should indicate the direction between adjacent points' do
    expect(subject.direction_between(origin,[1,0])).to eql(:east)
  end

  context "roses" do
    it 'should construct a simple rose' do
      %i[ north south east west ].each do |d| 
	expect(Compass.simple_rose.keys).to include(d) 
      end
    end

    it 'should construct an extended rose' do
      expect(Compass.extended_rose).to eql({
        :east  => [1, 0],
        :north => [0, -1],
        :northeast => [1, -1],
        :northwest => [-1, -1],
        :south => [0, 1],
        :southeast => [1, 1],
        :southwest => [-1, 1],
        :west => [-1, 0]
      })
    end
  end


  # it 'should accept alternative constructions....'
end
