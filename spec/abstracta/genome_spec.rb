require 'spec_helper'
require 'ostruct'
require 'abstracta/extend/range'
require 'abstracta/genome'

describe Abstracta::Genome do
  subject { Abstracta::Genome.default }

  context "defaults" do
    it 'should have sane options' do
      #expect(subject.mobile).to be(true)
      #expect(subject.sterile).to be(false)
      expect(subject.growth.limit).to  be_an(Integer) #eql(10)
      #expect(subject.growth.radius).to be_an(Integer) #eql(10)

    end
  end
end
