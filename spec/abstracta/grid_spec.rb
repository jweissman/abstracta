require 'spec_helper'
require 'active_support/core_ext/array'
require 'abstracta/extend/array'
require 'abstracta/rose'
require 'abstracta/compass'
require 'abstracta/grid'

describe Abstracta::Grid do
  it "should have width and height" do
    expect(subject.width).to  eql(10)
    expect(subject.height).to eql(10)
  end

  it 'should express this geometry as an array called dimensions' do 
    expect(subject.dimensions).to eql([subject.width, subject.height])
  end

  describe ".elements" do 
    subject { Abstracta::Grid.new([2,2]) }

    it 'should iterate over the grid' do
      expect(subject.elements).to eql([[0, 0], [0, 1], [1, 0], [1, 1]])
    end
  end

  describe "#first" do
    subject { Abstracta::Grid.new }
    its(:first) { should eql([0,0]) }
  end
end
