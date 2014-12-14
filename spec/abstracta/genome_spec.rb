require 'spec_helper'
require 'bindata'
require 'abstracta/genome'

describe Abstracta::Genome do
  subject { Abstracta::Genome.default }

  context "defaults" do
    it 'should have sane options' do
      expect(subject.mobile).to eql(1)
      expect(subject.sterile).to eql(0)
      expect(subject.growth_limit).to eql(10)
    end
  end

  context "#write" do
    let(:io) { StringIO.new }

    let(:genome) do
      subject.write(io)
      io.rewind
      Abstracta::Genome.read(io)
    end

    it 'should have a binary representation' do
      # for some reason we need to_s to compare representations... even though these are ==  :/
      # also what is up with the binary thing (not being able to call <boolean>?, or apparently
      # even overwrite it??)
      # too weird :(
      expect(genome.to_s).to eql(subject.to_s)
    end
  end
end
