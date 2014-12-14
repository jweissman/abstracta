require 'spec_helper'
require 'abstracta/compass'

describe Abstracta::Compass do
  let(:origin) { [0,0] }

  it 'should translate points' do
    expect(subject.move([0,1],:north)).to eql(origin)
    expect(subject.move([-1,0],:east)).to eql(origin)
    expect(subject.move(origin, :south)).to eql([0,1])
  end

  it 'should project points' do
    expect(subject.project(origin)).to eql(subject.class.extended_rose.values)
  end

  it 'should indicate the direction between adjacent points' do
    expect(subject.direction_between(origin,[1,0])).to eql(:east)
  end

  # it 'should accept alternative constructions....'
end
