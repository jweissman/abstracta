require 'spec_helper'
require 'abstracta'

describe Abstracta::Engine do
  let(:world) { subject.worlds.first }

  it 'should have worlds' do
    expect(world).to be_a(Abstracta::World)
  end

  it 'should move worlds' do
    expect { subject.step }.to change { world.age }.by(1)
  end

  context "#step" do
    it 'should yield on events' do
      mock_observer = double
      an_engine = kind_of(Abstracta::Engine)
      expect(mock_observer).to receive(:observe).with(an_engine)
      subject.step { |e| mock_observer.observe(e) }
    end
  end

  context "#turn" do
    before { subject.turn }
    after  { subject.halt }

    it 'should be running' do
      expect(subject.running).to be(true)
    end

  end
end
