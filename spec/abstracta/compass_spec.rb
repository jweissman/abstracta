require 'spec_helper'
require 'active_support/core_ext/array'
require 'abstracta/rose'
require 'abstracta/compass'
include Abstracta

describe Compass do
  let(:origin) { [0,0] }

  it 'should translate points' do
    expect(subject.move([0,1],:north)).to eql(origin)
    expect(subject.move([-1,0],:east)).to eql(origin)
    expect(subject.move(origin, :south)).to eql([0,1])
  end

  context "roses" do
    it 'should construct a simple rose' do
      %i[ north south east west ].each do |d| 
	expect(Rose.simple.directions.keys).to include(d) 
      end
    end

    it 'should construct an extended rose' do
      expect(Rose.extended.directions).to eql({
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
end
