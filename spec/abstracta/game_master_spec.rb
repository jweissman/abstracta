require 'spec_helper'
require 'abstracta'

describe Abstracta::GameMaster do
  let(:surface) { double(:width => 100, :height => 100) }
  before { subject.prepare_stage([surface.width, surface.height]) }

  it 'should have a world in its current scene' do
    has_world = subject.current_scene.values.any? { |e| e.is_a?(Abstracta::World) }
    expect(has_world).to eql(true)
  end
end
