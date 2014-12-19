require 'spec_helper'
require 'abstracta/genome'

describe Abstracta::Genome do
  subject { Abstracta::Genome.default }

  context "defaults" do
    it 'should have sane options' do
      expect(subject.mobile).to be(true)
      expect(subject.sterile).to be(false)
      expect(subject.growth_limit).to eql(10)
    end
  end
end
