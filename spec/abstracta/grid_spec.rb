require 'spec_helper'
require 'active_support/core_ext/array'
require 'abstracta/extend/array'
require 'abstracta/compass'
require 'abstracta/grid'

describe Abstracta::Grid do
  it "should have width and height" do
    expect(subject.width).to  eql(Abstracta::Grid::DEFAULT_WIDTH)
    expect(subject.height).to eql(Abstracta::Grid::DEFAULT_HEIGHT)
  end

  it 'should express this geometry as an array called dimensions' do 
    expect(subject.dimensions).to eql([subject.width, subject.height])
  end

  describe "#each" do 
    subject { Abstracta::Grid.new([2,2]) }
    let(:gathered) { subject.each { |x,y| [x,y] }}
    it 'should iterate over the grid' do
      expect(gathered).to eql([[0,0],[0,1],[1,0],[1,1]])
    end
  end
end
