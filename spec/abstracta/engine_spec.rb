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
end
