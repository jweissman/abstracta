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

  #context "#write" do
  #  let(:io) { StringIO.new }

  #  let(:genome) do
  #    subject.write(io)
  #    io.rewind
  #    Abstracta::Genome.read(io)
  #  end

  #  it 'should have a binary representation' do
  #    # for some reason we need to_s to compare representations... even though these are ==  :/
  #    # also what is up with the binary thing (not being able to call <boolean>?, or apparently
  #    # even overwrite it??)
  #    # too weird :(
  #    expect(genome.mobile).to eql(subject.mobile)
  #    expect(genome.growth_cycle).to eql(subject.growth_cycle)
  #    # etc...
  #    # can't do the whole thing now because of how floating points mutate the value!
  #  end
  #end
end
