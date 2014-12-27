require 'spec_helper'
require 'pry'
require 'abstracta'
require 'abstracta/game_master'

describe Abstracta::GameMaster do
  let(:surface) { double(:width => 1, :height => 1) }
  before { subject.prepare_stage([surface.width, surface.height]) }
  it 'should have a world in its current scene' do
    has_world = subject.current_scene.values.any? { |e| e.is_a?(World) }
    expect(has_world).to eql(true)
  end
end
