require 'spec_helper'
require 'bindata'

require 'active_support/core_ext/array'
require 'abstracta/extend/array'
require 'abstracta/occupant' 

describe Abstracta::Occupant do
  it 'should have a position' do
    expect(subject.x).to be_an Integer
    expect(subject.y).to be_an Integer
  end

  context "#age" do
    it 'should be a year older' do
      expect { subject.step }.to change { subject.age }.by 1
    end
  end

  #it 'should have a genetic code' do
  #  expect(subject.dna).to be_a Abstracta::Genome
  #end
end


